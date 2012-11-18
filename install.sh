#! /bin/sh

ln -sf ~/conf/bashrc ~/.bashrc
ln -sf ~/conf/bash_aliases ~/.bash_aliases

ln -sf ~/conf/vimrc ~/.vimrc
ln -sf ~/conf/vim ~/.vim

ln -sf ~/conf/irbrc ~/.irbrc
ln -sf ~/conf/gemrc ~/.gemrc

ln -sf ~/conf/git-completion ~/.git-completion
ln -sf ~/conf/gitconfig ~/.gitconfig
ln -sf ~/conf/git_template ~/.git_template
ln -sf ~/conf/gitignore_global ~/.gitignore_global

ln -sf ~/conf/js ~/.js
ln -sf ~/conf/gvimrc ~/.gvimrc

ln -sf ~/conf/ackrc ~/.ackrc

ln -sf ~/conf/tmux.conf ~/.tmux.conf

mkdir -p ~/bin
for script in $(ls ~/conf/bin); do
  ln -sf ~/conf/bin/$script ~/bin/$script
done
