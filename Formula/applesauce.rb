class Applesauce < Formula
  desc "A command-line interface for compressing and decompressing files using macos transparent compression"
  version "0.5.4"
  on_macos do
    on_arm do
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.5.4/applesauce-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d0e4a33c5f5a551c3037dfe933ca487cfa45b40d9023cb718984818e19a6a86d"
    end
    on_intel do
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.5.4/applesauce-cli-x86_64-apple-darwin.tar.xz"
      sha256 "033e037ff0109da511cc52d9fa766d419efd248bfc76024ef5366148919e57fd"
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
