class Applesauce < Formula
  desc "A command-line interface for compressing and decompressing files using macos transparent compression"
  version "0.5.0"
  on_macos do
    on_arm do
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.5.0/applesauce-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d23ee222b038e88e24cea19147a5f338b7938e2f023e3d5b383f48213431185b"
    end
    on_intel do
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.5.0/applesauce-cli-x86_64-apple-darwin.tar.xz"
      sha256 "3e8383545dba863a30e19de34c0b2b8c57f4ca3fc6de7ca3780e9cc154845832"
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
