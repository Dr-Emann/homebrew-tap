class Applesauce < Formula
  desc "A command-line interface for compressing and decompressing files using macos transparent compression"
  homepage "https://github.com/Dr-Emann/applesauce"
  version "0.5.29"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.5.29/applesauce-cli-aarch64-apple-darwin.tar.xz"
      sha256 "595656e58a905613b70da6009a5c99fc874b038b7ddad9c4bc54f4f336b5dc3a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.5.29/applesauce-cli-x86_64-apple-darwin.tar.xz"
      sha256 "eb46692869a548457339b4182a43dd2d9ebc88f0ccd7914235d5546b0cd39028"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "applesauce"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "applesauce"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
