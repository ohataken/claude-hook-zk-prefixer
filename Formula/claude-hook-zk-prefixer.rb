class ClaudeHookZkPrefixer < Formula
  desc "My little utility for Claude Code hooks"
  homepage "https://github.com/ohataken/claude-hook-zk-prefixer"
  version "0.0.4"

  on_arm do
    url "https://github.com/ohataken/claude-hook-zk-prefixer/releases/download/v#{version}/claude-hook-zk-prefixer-aarch64-apple-darwin.tar.gz"
    sha256 "7a7c3d39de949667d5ac86a8c733622862a3f551c45812d4de5cde16f1ed8054"
  end

  def install
    bin.install "claude-hook-zk-prefixer"
  end
end
