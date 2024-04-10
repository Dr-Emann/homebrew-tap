class Applesauce < Formula
  desc "A command-line interface for compressing and decompressing files using macos transparent compression"
  version "0.4.6"
  on_macos do
    on_arm do
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.4.6/applesauce-cli-aarch64-apple-darwin.tar.xz"
      sha256 "34e9d440ed5637cc49048c08b95c04322f701f92085eaaec8c19f786d5be48fd"
    end
    on_intel do
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.4.6/applesauce-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f426250ea15a8eaaf2093d4497e999d56d7c07b031556498593dafc641de1120"
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
