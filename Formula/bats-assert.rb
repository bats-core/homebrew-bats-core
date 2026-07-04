class BatsAssert < Formula
  desc "Common assertions for Bats"
  homepage "https://github.com/bats-core/bats-assert"
  url "https://github.com/bats-core/bats-assert/archive/refs/tags/v2.2.4.tar.gz"
  sha256 "e305df20c4c36cba4570e10f1cd824efb1ae71d88b5ef474550781ebee04192f"
  license "MIT"
  head "https://github.com/bats-core/bats-assert.git", branch: "master"

  def install
    mkdir "bats-assert"
    mv "load.bash", "bats-assert/"
    mv "src", "bats-assert/"
    mv "test", "bats-assert/"
    lib.install "bats-assert"
  end

  def caveats
    <<~EOS
      To load the bats-assert lib in your bats test:
          #Set the bats_lib_path
          export BATS_LIB_PATH="${BATS_LIB_PATH}:${HOMEBREW_PREFIX}/lib"
          bats_load_library bats-support
          bats_load_library bats-assert
    EOS
  end

  test do
    (testpath/"test.bats").write <<~EOS
      setup() {
        export BATS_LIB_PATH="${BATS_LIB_PATH}:${HOMEBREW_PREFIX}/lib"
        bats_load_library bats-support
        bats_load_library bats-assert
      }

      @test "assert true" {
        assert true
      }

      @test "refute false" {
        refute false
      }

      @test "assert equal" {
        assert_equal '42' '42'
      }
    EOS
    ENV["TEST_DEPS_DIR"] = "#{HOMEBREW_PREFIX}/lib"
    system "bats", "test.bats"
  end
end
