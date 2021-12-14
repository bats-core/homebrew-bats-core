# homebrew-bats-core

Repository for managing bats-core and its dependencies on homebrew

## Installation

OS X users can use Homebrew to install libraries system-wide

```
$ brew install bats-core
```
Then install the desired libraries.
```
$ brew tap bats-core/bats-core
$ brew install bats-support
$ brew install bats-assert
$ brew install bats-file
$ brew install bats-detik
```

For brew installations, load the libraries from $(brew --prefix)/lib/ (the brew prefix is /usr/local by default):

```bash
TEST_BREW_PREFIX="$(brew --prefix)"
load "${TEST_BREW_PREFIX}/lib/bats-support/load.bash"
load "${TEST_BREW_PREFIX}/lib/bats-assert/load.bash"
load "${TEST_BREW_PREFIX}/lib/bats-file/load.bash"
load "${TEST_BREW_PREFIX}/lib/bats-detik/load.bash"
```
