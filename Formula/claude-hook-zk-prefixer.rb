class ClaudeHookZkPrefixer < Formula
  desc "My little utility for Claude Code hooks"
  homepage "https://github.com/ohataken/claude-hook-zk-prefixer"
  version "0.0.3"

  on_arm do
    url "https://github.com/ohataken/claude-hook-zk-prefixer/releases/download/v#{version}/claude-hook-zk-prefixer-aarch64-apple-darwin.tar.gz"
    sha256 "30c4acf86f3743f87e46b6904db550a2c0cfbcc1a6be674e1f8b18cd74ba9abf"
  end

  def install
    bin.install "claude-hook-zk-prefixer"
  end
end
