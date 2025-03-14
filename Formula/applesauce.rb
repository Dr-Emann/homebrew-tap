class Applesauce < Formula
  desc "A command-line interface for compressing and decompressing files using macos transparent compression"
  homepage "https://github.com/Dr-Emann/applesauce"
  version "0.5.13"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.5.13/applesauce-cli-aarch64-apple-darwin.tar.xz"
      sha256 "38dc321095a2a472f5b56b3ac3e4860d861e3278a02488e89fc2008c0f47091b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.5.13/applesauce-cli-x86_64-apple-darwin.tar.xz"
      sha256 "eba9455942965f1236552b64b4421f65ebe98b563a664e5c573e1b55085b1ef1"
    end
  end
  license "GPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "applesauce" if OS.mac? && Hardware::CPU.arm?
    bin.install "applesauce" if OS.mac? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
