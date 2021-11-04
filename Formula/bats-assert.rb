class BatsAssert < Formula
  desc "Common assertions for Bats"
  homepage "https://github.com/bats-core/homebrew-bats-core"
  url "https://github.com/bats-core/bats-assert/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "15dbf1abb98db785323b9327c86ee2b3114541fe5aa150c410a1632ec06d9903"
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
    ENV["TEST_DEPS_DIR"] = "#{HOMEBREW_PREFIX}/lib"
    system "bats", "#{lib}/bats-assert/test"
  end
end
