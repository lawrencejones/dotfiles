# Installation on OS X

A handy place to keep a step by step guide to install software on OS X.

## Activate XCode

Simply run a command that would require dev tools, and trigger the install...

```bash
git
```

## Install Brew

Standard package manager for OS X, plus basic binarys.

```bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade

brew tap homebrew/dupes
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
brew install gpg
brew install tree
```

## Clone dotfiles

```bash
cd $HOME && \
git clone https://github.com/LawrenceJones/dotfiles && \
cd $HOME/dotfiles && \
./symlink
```

## Extra Apps

[Karabiner](https://pqrs.org/osx/karabiner/) for key repeat, custom key settings.
[Spectacle](http://spectacleapp.com/) for window management.
