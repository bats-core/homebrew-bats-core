class BatsFile < Formula
  desc "Common filesystem assertions for Bats"
  homepage "https://github.com/bats-core/bats-file"
  url "https://github.com/bats-core/bats-file/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "9b69043241f3af1c2d251f89b4fcafa5df3f05e97b89db18d7c9bdf5731bb27a"
  license "MIT"
  head "https://github.com/bats-core/bats-file.git", branch: "master"

  def install
    mkdir "bats-file"
    mv "load.bash", "bats-file/"
    mv "src", "bats-file/"
    mv "test", "bats-file/"
    lib.install "bats-file"
  end

  def caveats
    <<~EOS

      To load the bats-file lib in your bats test:

          #Set the bats_lib_path
          export BATS_LIB_PATH="${BATS_LIB_PATH}:${HOMEBREW_PREFIX}/lib"
          bats_load_library bats-support
          bats_load_library bats-file
    EOS
  end

  test do
    (testpath/"test.bats").write <<~EOS
      setup() {
        export BATS_LIB_PATH="${BATS_LIB_PATH}:${HOMEBREW_PREFIX}/lib"
        bats_load_library bats-support
        bats_load_library bats-file
      }

      @test 'assert_file_exist() <file>: returns 0 if <file> exists' {
        local -r file="myfile"
        run assert_file_exist "$file"
        [ "$status" -eq 0 ]
        [ "${#lines[@]}" -eq 0 ]
      }

      @test 'assert_file_exist() <file>: returns 1 and displays path if <file> does not exist' {
        local -r file="mydir"
        run assert_file_exist "$file"
        [ "$status" -eq 1 ]
        [ "${#lines[@]}" -eq 3 ]
        [ "${lines[0]}" == '-- file does not exist --' ]
        [ "${lines[1]}" == "path : $file" ]
        [ "${lines[2]}" == '--' ]
      }
    EOS
    ENV["TEST_DEPS_DIR"] = "#{HOMEBREW_PREFIX}/lib"
    File.write("myfile", "")
    Dir.mkdir "mydir"
    system "bats", "test.bats"
  end
end
