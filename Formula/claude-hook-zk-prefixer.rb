class ClaudeHookZkPrefixer < Formula
  desc "My little utility for Claude Code hooks"
  homepage "https://github.com/ohataken/claude-hook-zk-prefixer"
  version "0.0.2"

  on_arm do
    url "https://github.com/ohataken/claude-hook-zk-prefixer/releases/download/v#{version}/claude-hook-zk-prefixer-aarch64-apple-darwin.tar.gz"
    sha256 "dd78de0ab69415fd0b60aa08183f132eb913de9695a29e44d13655bcdc8cf9e3"
  end

  def install
    bin.install "claude-hook-zk-prefixer"
  end
end
