class ClaudeHookZkPrefixer < Formula
  desc "My little utility for Claude Code hooks"
  homepage "https://github.com/ohataken/claude-hook-zk-prefixer"
  version "0.0.1"

  on_arm do
    url "https://github.com/ohataken/claude-hook-zk-prefixer/releases/download/v#{version}/claude-hook-zk-prefixer-aarch64-apple-darwin.tar.gz"
    sha256 "9d2ecc73f7349a9a23fe6c213ddc0c7fb2a411bcbb935ab74d890b8857c22aa7"
  end

  def install
    bin.install "claude-hook-zk-prefixer"
  end
end
