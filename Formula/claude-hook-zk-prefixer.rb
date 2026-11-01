class ClaudeHookZkPrefixer < Formula
  desc "My little utility for Claude Code hooks"
  homepage "https://github.com/ohataken/claude-hook-zk-prefixer"
  version "0.0.6"

  on_arm do
    url "https://github.com/ohataken/claude-hook-zk-prefixer/releases/download/v#{version}/claude-hook-zk-prefixer-aarch64-apple-darwin.tar.gz"
    sha256 "cfcac1a3bd71d35273377c5c85d7a2a48c743c3cf14c09d73d83c7de994320b6"
  end

  def install
    bin.install "claude-hook-zk-prefixer"
  end
end
