class BatsAssert < Formula
    desc "Common assertions for Bats"
    homepage "https://github.com/bats-core/homebrew-bats-core"
    url "bats-assert"
    version ""
    sha256 ""
    license ""

    # depends_on "cmake" => :build

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

