class BatsSupport < Formula
  desc "Supporting library for Bats test helpers"
  homepage "https://github.com/bats-core/homebrew-bats-core"
  url "https://github.com/bats-core/bats-support/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "7815237aafeb42ddcc1b8c698fc5808026d33317d8701d5ec2396e9634e2918f"
  license "MIT"
  head "https://github.com/bats-core/bats-support.git", branch: "master"
  depends_on "bats-core"

  def install
    mkdir "bats-support"
    mv "load.bash", "bats-support/"
    mv "src", "bats-support/"
    mv "test", "bats-support/"
    lib.install "bats-support"
  end

  def caveats
    <<~EOS

      To load the bats-support lib in your bats test:

          #Set the bats_lib_path
          export BATS_LIB_PATH="${BATS_LIB_PATH}:${HOMEBREW_PREFIX}/lib"
          bats_load_library bats-support
    EOS
  end

  test do
    ENV["TEST_DEPS_DIR"] = "#{HOMEBREW_PREFIX}/lib"
    system "bats", "#{lib}/bats-support/test"
  end
end
