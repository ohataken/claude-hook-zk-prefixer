class ClaudeHookZkPrefixer < Formula
  desc "My little utility for Claude Code hooks"
  homepage "https://github.com/ohataken/claude-hook-zk-prefixer"
  version "0.0.5"

  on_arm do
    url "https://github.com/ohataken/claude-hook-zk-prefixer/releases/download/v#{version}/claude-hook-zk-prefixer-aarch64-apple-darwin.tar.gz"
    sha256 "5f17ce15dae921ad407c738da250abe51732b3c29577e03811ec13b13f33df3a"
  end

  def install
    bin.install "claude-hook-zk-prefixer"
  end
end
