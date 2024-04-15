class Applesauce < Formula
  desc "A command-line interface for compressing and decompressing files using macos transparent compression"
  version "0.5.2"
  on_macos do
    on_arm do
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.5.2/applesauce-cli-aarch64-apple-darwin.tar.xz"
      sha256 "519910879afd02d1e7422b8506296f16863f2c4e873074d4d84013f3a2b21c38"
    end
    on_intel do
      url "https://github.com/Dr-Emann/applesauce/releases/download/applesauce-cli-v0.5.2/applesauce-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7b9022ef902f998a410fa87b0dc3c649e43862b4500fdff3ff23d2a00ee6896b"
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
