class Droploid < Formula
  desc "CLI to deploy Flutter & native iOS/Android apps to the App Store & Play Store"
  homepage "https://github.com/mhdibrahimcn/droploid-cli"
  license "MIT"
  # Builds the app repo from source. TODO: pin a release tarball + sha256 for a stable formula.
  head "https://github.com/mhdibrahimcn/Droploid-_electron.git", branch: "main"

  depends_on "node"

  def install
    system "npm", "ci"
    system "npm", "run", "build"
    libexec.install Dir["*"]
    (bin/"droploid").write <<~SH
      #!/bin/bash
      exec "#{libexec}/node_modules/.bin/electron" "#{libexec}/out/main/index.js" --cli "$@"
    SH
  end

  test do
    assert_match "droploid", shell_output("#{bin}/droploid help 2>&1")
  end
end
