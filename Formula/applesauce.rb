class Applesauce < Formula
  desc "A command-line interface for compressing and decompressing files using macos transparent compression"
  homepage "https://github.com/Dr-Emann/applesauce"
  version "0.5.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.5.11/applesauce-cli-aarch64-apple-darwin.tar.xz"
      sha256 "04610f5ea7d1b9f2a0bd90f6d437549bce93d2eeb8c3c1e4761941b5991bc9cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.5.11/applesauce-cli-x86_64-apple-darwin.tar.xz"
      sha256 "2b597529ea6b85315f5ff22357167926e3eae1327cc17d5836cb1150736436cd"
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
