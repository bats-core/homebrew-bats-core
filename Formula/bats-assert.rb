class BatsAssert < Formula
  desc "Common assertions for Bats"
  homepage "https://github.com/bats-core/bats-assert"
  url "https://github.com/bats-core/bats-assert/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "98ca3b685f8b8993e48ec057565e6e2abcc541034ed5b0e81f191505682037fd"
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
          load '#{HOMEBREW_PREFIX}/lib/bats-support/load.bash'
          load '#{HOMEBREW_PREFIX}/lib/bats-assert/load.bash'
    EOS
  end

  test do
    (testpath/"test.bats").write <<~EOS
      setup() {
        load '#{HOMEBREW_PREFIX}/lib/bats-support/load.bash'
        load '#{HOMEBREW_PREFIX}/lib/bats-assert/load.bash'
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
