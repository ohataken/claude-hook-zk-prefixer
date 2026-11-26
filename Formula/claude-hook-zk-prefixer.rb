class ClaudeHookZkPrefixer < Formula
  desc "My little utility for Claude Code hooks"
  homepage "https://github.com/ohataken/claude-hook-zk-prefixer"
  version "0.0.7"

  on_arm do
    url "https://github.com/ohataken/claude-hook-zk-prefixer/releases/download/v#{version}/claude-hook-zk-prefixer-aarch64-apple-darwin.tar.gz"
    sha256 "846c6136bbde75b0a7414bbea2acd7b6309ecb9ecf02dba021c6817cfce05e19"
  end

  def install
    bin.install "claude-hook-zk-prefixer"
  end
end
