#! /bin/sh

ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/bash_aliases ~/.bash_aliases

ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/vim ~/.vim

ln -sf ~/dotfiles/irbrc ~/.irbrc
ln -sf ~/dotfiles/gemrc ~/.gemrc

ln -sf ~/dotfiles/git-completion ~/.git-completion
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/git_template ~/.git_template
ln -sf ~/dotfiles/gitignore_global ~/.gitignore_global

ln -sf ~/dotfiles/js ~/.js
ln -sf ~/dotfiles/gvimrc ~/.gvimrc

ln -sf ~/dotfiles/ackrc ~/.ackrc

ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf

mkdir -p ~/bin
for script in $(ls ~/dotfiles/bin); do
  ln -sf ~/dotfiles/bin/$script ~/bin/$script
done
