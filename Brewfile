#!/usr/bin/env ruby

brews = %w{
  coreutils
  findutils
  gnu-tar
  gnu-sed
  gawk
  gnutls
  gnu-indent
  gnu-getopt
  gnu-sed

  git
  ruby-build
  rbenv
  ack
  ctags
  mercurial
  mongodb
  phantomjs
  wget
  vim
  cmake
  redis
  the_silver_searcher
  git-extras
  youtube-dl
  hub
  python
  tree
  tmux
  phantomjs
 }

INSTALLED_BREWS = `brew list`.split("\n")

brews.each do |brew|
  if INSTALLED_BREWS.include?(brew)
    puts "#{brew} already installed"
  else
    puts "Installing #{brew}..."
    puts `brew install #{brew}`
  end
end
