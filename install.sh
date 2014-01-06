#! /bin/sh

case `uname` in
  'Darwin')
    dircmd='ln -sfh'
    ;;
  'Linux')
    dircmd='ln -sfT'
    ;;
esac

ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/bash_aliases ~/.bash_aliases

ln -sf ~/dotfiles/inputrc ~/.inputrc

ln -sf ~/dotfiles/vimrc ~/.vimrc
$dircmd ~/dotfiles/vim ~/.vim

ln -sf ~/dotfiles/irbrc ~/.irbrc
ln -sf ~/dotfiles/gemrc ~/.gemrc
ln -sf ~/dotfiles/pryrc ~/.pryrc

ln -sf ~/dotfiles/git-completion ~/.git-completion
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
$dircmd ~/dotfiles/git_template ~/.git_template
ln -sf ~/dotfiles/gitignore_global ~/.gitignore_global

$dircmd ~/dotfiles/js ~/.js
ln -sf ~/dotfiles/gvimrc ~/.gvimrc

ln -sf ~/dotfiles/ackrc ~/.ackrc

ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/tmux-osx.conf ~/.tmux-osx.conf

mkdir -p ~/bin
for script in $(ls ~/dotfiles/bin); do
  ln -sf ~/dotfiles/bin/$script ~/bin/$script
done
