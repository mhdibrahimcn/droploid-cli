# Droploid CLI

> **Deploy Flutter, iOS & Android apps to the App Store, TestFlight & Google Play — from one command.** Built for humans *and* AI agents.

This is the **distribution repo** for the Droploid CLI. The application source lives in
[**mhdibrahimcn/Droploid-_electron**](https://github.com/mhdibrahimcn/Droploid-_electron) and is
included here as the `app/` git submodule. This repo packages the installer, the Homebrew formula,
and the agent skill.

`droploid` builds, signs, versions, and uploads Flutter and native iOS/Android projects to the
**Apple App Store**, **TestFlight**, and the **Google Play Store** — plus **Shorebird** OTA
code-push patches — without a GUI. Every command speaks JSON, so an **AI agent** can drive your
whole mobile release pipeline.

```bash
droploid setup                                   # guided, no-flags first-time setup
droploid deploy MyApp --track production --bump patch --json
```

---

## Install

### Homebrew (macOS & Linux)

```bash
brew install --HEAD mhdibrahimcn/tap/droploid
# or, from this repo:
brew install --HEAD ./HomebrewFormula/droploid.rb
```

### From source (git submodule)

```bash
git clone --recurse-submodules https://github.com/mhdibrahimcn/droploid-cli.git
cd droploid-cli && ./install.sh
```

`install.sh` builds the `app/` submodule and drops a `droploid` shim on your `PATH`
(`/usr/local/bin` or `~/.local/bin`). Already cloned without submodules? Run
`git submodule update --init --recursive` first (the installer also does this for you).

---

## Commands

| Command | Description |
|---|---|
| `droploid setup` | Interactive first-time setup — no flags, just answer prompts |
| `droploid orgs` / `apps` / `tools` | List orgs / apps / check toolchain |
| `droploid link <dir> --org <id\|name>` | Detect & link a Flutter/iOS/Android project |
| `droploid config-org --name <name> [creds]` | Create/update an org non-interactively |
| `droploid preflight <app>` | Pre-deploy checks |
| `droploid deploy <app> [opts]` | Build, sign & upload |
| `droploid patch <app>` | Shorebird OTA patch (no store upload) |
| `droploid history <app>` | Recent build runs |

App/org resolve by **id or name**, or positionally (`droploid deploy MyApp`). Run `droploid --help` for all flags.

### Where to get credentials

- **iOS** — App Store Connect ▸ Users and Access ▸ Integrations ▸ App Store Connect API (Issuer ID, Key ID, download the `.p8` once).
- **Android** — Google Cloud Console ▸ IAM & Admin ▸ Service Accounts ▸ Keys ▸ Add key ▸ JSON, then grant that service-account email in Play Console ▸ Users and permissions / API access.

`droploid setup` prints these hints inline as it asks.

---

## For AI agents

Every command accepts `--json`: **stdout** = one JSON result, **stderr** = logs, **exit** `0`=ok/`1`=fail.
A ready-made agent skill ships in [`.claude/skills/droploid-deploy/`](.claude/skills/droploid-deploy/SKILL.md).

---

## Repos

- **App source:** [Droploid-_electron](https://github.com/mhdibrahimcn/Droploid-_electron) (Electron app + CLI)
- **Distribution (this):** [droploid-cli](https://github.com/mhdibrahimcn/droploid-cli) — installer, formula, skill

## License

MIT
