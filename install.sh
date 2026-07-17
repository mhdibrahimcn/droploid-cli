#!/usr/bin/env bash
# Droploid CLI installer (macOS + Linux). Builds the app submodule, then drops a
# `droploid` shim on your PATH.
#   git clone --recurse-submodules https://github.com/mhdibrahimcn/droploid-cli.git
#   cd droploid-cli && ./install.sh
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
APP="$DIR/app"

# Pull the app submodule if it wasn't cloned with --recurse-submodules.
if [ ! -f "$APP/package.json" ]; then
  echo "→ Fetching app submodule"
  ( cd "$DIR" && git submodule update --init --recursive )
fi

command -v npm >/dev/null || { echo "npm required (install Node.js first)"; exit 1; }
echo "→ Building Droploid ($APP)"
( cd "$APP" && { [ -d node_modules ] || npm ci; } && npm run build )

pick_bindir() {
  for d in /usr/local/bin "$HOME/.local/bin"; do
    case ":$PATH:" in *":$d:"*) [ -w "$d" ] || [ ! -e "$d" ] && { echo "$d"; return; } ;; esac
  done
  echo "$HOME/.local/bin"
}
BINDIR="$(pick_bindir)"; mkdir -p "$BINDIR"
SHIM="$BINDIR/droploid"
cat > "$SHIM" <<EOF
#!/usr/bin/env bash
exec "$APP/node_modules/.bin/electron" "$APP/out/main/index.js" --cli "\$@"
EOF
chmod +x "$SHIM"

echo "✓ Installed: $SHIM"
case ":$PATH:" in *":$BINDIR:"*) ;; *) echo "  ⚠ Add to PATH:  export PATH=\"$BINDIR:\$PATH\"" ;; esac
echo "  Try:  droploid setup"
