#!/usr/bin/env bash

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
  elasticsearch51
  emacs
  ffmpeg
  geoip
  gist
  git
  grep
  gsl
  htop
  hub
  imagemagick
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
  pv
  reattach-to-user-namespace
  redis
  ripgrep
  ruby-install
  shellcheck
  sloccount
  solr
  swi-prolog
  tcpflow
  tmux
  tree
  unzip
  vim
  watch
  wget
  yarn
)

for p in "${packages[@]}"; do
  brew install "$p"
done
