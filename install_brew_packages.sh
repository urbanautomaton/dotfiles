#!/usr/bin/env bash

set -euo pipefail

packages=(
  ack
  automake
  bash
  bash-completion
  bdw-gc
  bison
  boost
  chruby
  coreutils
  ctags
  dos2unix
  emacs
  ffmpeg
  geoip
  gist
  git
  grep
  gsl
  htop
  hub
  jq
  leiningen
  libev
  little-cms
  llvm
  netcat
  parallel
  phantomjs
  pkg-config
  plantuml
  postgres
  pv
  reattach-to-user-namespace
  redis
  ripgrep
  ruby-install
  shellcheck
  shunit2
  sloccount
  swi-prolog
  tcpflow
  tmux
  tree
  unzip
  watch
  wget
  yarn
)

for p in "${packages[@]}"; do
  brew install "$p"
done

brew install imagemagick --with-little-cms2
brew install vim --with-python3
brew install --HEAD https://raw.github.com/postmodern/gem_home/master/homebrew/gem_home.rb

cask_packages=(
  1password
  alfred
  chefdk
  evernote
  flux
  google-chrome
  iterm2
  shiftit
  slack
  spotify
  vlc
)

brew tap caskroom/cask

for p in "${cask_packages[@]}"; do
  brew cask install "$p"
done
