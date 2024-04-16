class Applesauce < Formula
  desc "A command-line interface for compressing and decompressing files using macos transparent compression"
  version "0.5.3"
  on_macos do
    on_arm do
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.5.3/applesauce-cli-aarch64-apple-darwin.tar.xz"
      sha256 "92dadad1eea2f61d3b4c5baaade0b6e9af42028a44ec96608bd6c61524e14496"
    end
    on_intel do
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.5.3/applesauce-cli-x86_64-apple-darwin.tar.xz"
      sha256 "31bf06a2a7309845a6a40926307909804f283350eca9620d0fbddfa2fc7cfdbb"
    end
  end
  license "GPL-3.0-or-later"

  def install
    on_macos do
      on_arm do
        bin.install "applesauce"
      end
    end
    on_macos do
      on_intel do
        bin.install "applesauce"
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
