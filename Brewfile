#!/bin/zsh

exclude-installed() {
  grep -Ev ""$(brew list | xargs | sed 's/ /|/g')""
}

brew update
brew upgrade

brew tap homebrew/dupes

echo """
brew install coreutils

brew install coreutils
brew install findutils
brew install gnu-tar
brew install gnu-sed
brew install gawk
brew install gnutls
brew install gnu-indent
brew install gnu-getopt
brew install gnu-sed

brew install git
brew install ruby-build
brew install rbenv
brew install ack
brew install ctags
brew install mercurial
brew install mongodb
brew install phantomjs
brew install wget
brew install vim
brew install cmake
brew install redis
brew install the_silver_searcher
brew install git-extras
brew install youtube-dl
brew install hub
brew install python
brew install tree
brew install tmux
brew install phantomjs
""" | exclude-installed | tee | zsh
