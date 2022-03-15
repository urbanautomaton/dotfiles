#! /bin/bash

set -euo pipefail

case $(uname) in
  'Darwin')
    dircmd='ln -sfh'
    ;;
  'Linux')
    dircmd='ln -sfT'
    ;;
esac

readonly DOTDIRECTORIES="
  vim
  git_template
  env_hooks
"

readonly DOTFILES="
  bashrc
  bashrc.darwin
  bash_aliases
  bash_completion
  env_hooker
  inputrc
  vimrc
  irbrc
  gemrc
  pryrc
  gitconfig
  gitignore_global
  gitattributes
  gvimrc
  ackrc
  tmux.conf
  tmux-osx.conf
  terraformrc
"

for dir in $DOTDIRECTORIES; do
  if [[ -n "$dir" ]]; then
    $dircmd "${HOME}/dotfiles/${dir}" "${HOME}/.${dir}"
  fi
done

for file in $DOTFILES; do
  if [[ -n "$file" ]]; then
    ln -sf "${HOME}/dotfiles/${file}" "${HOME}/.${file}"
  fi
done

mkdir -p ~/bin
for script in ~/dotfiles/bin/*; do
  ln -sf "${HOME}/dotfiles/bin/${script}" "${HOME}/bin/${script}"
done
