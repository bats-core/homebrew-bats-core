# homebrew-bats-core

Repository for managing bats-core and its dependencies on homebrew

## Installation

OS X users can use Homebrew to install libraries system-wide

```bash
$ brew install bats-core
```

Then install the desired libraries.

```bash
$ brew tap bats-core/bats-core
$ brew install bats-support
$ brew install bats-assert
$ brew install bats-file
$ brew install bats-detik
```

For brew installations, load the libraries from $(brew --prefix)/lib/ (the brew prefix is /usr/local by default):

```bash
TEST_BREW_PREFIX="$(brew --prefix)"
export BATS_LIB_PATH="${BATS_LIB_PATH}:${TEST_BREW_PREFIX}/lib"
bats_load_library bats-support
bats_load_library bats-assert
bats_load_library bats-file
bats_load_library bats-detik/detik.bash
```
