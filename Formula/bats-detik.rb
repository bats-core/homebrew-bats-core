class BatsDetik < Formula
  desc "Library to ease e2e tests of applications in K8s environments"
  homepage "https://github.com/bats-core/bats-detik"
  url "https://github.com/bats-core/bats-detik/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "af6adfaafc5db94e0beaaace8cf36db01e5c4bca86b0f50740981bc06066d330"
  license "MIT"
  head "https://github.com/bats-core/bats-detik.git", branch: "master"

  def install
    mkdir "bats-detik"
    mv "lib/detik.bash", "bats-detik/"
    mv "lib/utils.bash", "bats-detik/"
    mv "lib/linter.bash", "bats-detik/"
    mv "examples", "bats-detik/"
    mv "tests", "bats-detik/"
    mv "Dockerfile", "bats-detik/"
    lib.install "bats-detik"
  end

  def caveats
    <<~EOS
      To load the bats-detik lib in your bats test:

          load '#{HOMEBREW_PREFIX}/lib/bats-detik/utils.bash'
          load '#{HOMEBREW_PREFIX}/lib/bats-detik/detik.bash'

          DETIK_CLIENT_NAME="kubectl"
    EOS
  end

  test do
    (testpath/"test.bats").write <<~EOS
      setup() {
        load '#{HOMEBREW_PREFIX}/lib/bats-detik/utils.bash'
        load '#{HOMEBREW_PREFIX}/lib/bats-detik/detik.bash'
      }

      DETIK_CLIENT_NAME="mytest"
      DETIK_CLIENT_NAMESPACE=""
      mytest() {
        # The namespace should not appear (it is set in 1st position)
        [[ "$1" != "--namespace=test_ns" ]] || return 1
        # Return the result
        echo -e "NAME  PROP\nnginx-deployment-75675f5897-6dg9r  Running\nnginx-deployment-75675f5897-gstkw  Running"
      }

      @test "verifying the number of PODs with the lower-case syntax (exact number, plural)" {
        run verify "there are 2 pods named 'nginx'"
        [ "$status" -eq 0 ]
        [ ${#lines[@]} -eq 2 ]
        [ "${lines[0]}" = "Valid expression. Verification in progress..." ]
        [ "${lines[1]}" = "Found 2 pods named nginx (as expected)." ]
      }

      @test "verifying the number of PODs with the lower-case syntax (exact number, singular)" {
        run verify "there is 1 pod named 'nginx-deployment-75675f5897-6dg9r'"
        [ "$status" -eq 0 ]
        [ ${#lines[@]} -eq 2 ]
        [ "${lines[0]}" = "Valid expression. Verification in progress..." ]
        [ "${lines[1]}" = "Found 1 pod named nginx-deployment-75675f5897-6dg9r (as expected)." ]
      }

      @test "verifying the number of PODs with an invalid name" {
        run verify "There are 2 pods named 'nginx-inexisting'"
        [ "$status" -eq 3 ]
        [ ${#lines[@]} -eq 2 ]
        [ "${lines[0]}" = "Valid expression. Verification in progress..." ]
        [ "${lines[1]}" = "Found 0 pods named nginx-inexisting (instead of 2 expected)." ]
      }
    EOS
    ENV["TEST_DEPS_DIR"] = "#{HOMEBREW_PREFIX}/lib"
    system "bats", "test.bats"
  end
end
