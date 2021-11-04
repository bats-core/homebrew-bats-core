class BatsDetik < Formula
  desc "Library to ease e2e tests of applications in K8s environments"
  homepage "https://github.com/bats-core/bats-detik"
  url "https://github.com/bats-core/bats-detik/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "1467f5f1d51211a0cb163cfceee65796e710fe8b3f4b6731d404eb075e9147e3"
  license "MIT"
  head "https://github.com/bats-core/bats-detik.git", branch: "master"

  def install
    mkdir "bats-detik"
    mv "lib", "bats-detik/"
    mv "examples", "bats-detik/"
    mv "tests", "bats-detik/"
    mv "Dockerfile", "bats-detik/"
    lib.install "bats-detik"
  end

  def caveats
    <<~EOS
      To load the bats-detik lib in your bats test:

          load '#{HOMEBREW_PREFIX}/lib/bats-detik/lib/utils'
          load '#{HOMEBREW_PREFIX}/lib/bats-detik/lib/detik'

          DETIK_CLIENT_NAME="kubectl"
    EOS
  end

  test do
    ENV["TEST_DEPS_DIR"] = "#{HOMEBREW_PREFIX}/lib"
    system "bats", "#{lib}/bats-detik/tests"
  end
end
