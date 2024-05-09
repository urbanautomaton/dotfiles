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
  ackrc
  bash_aliases
  bash_completion
  bashrc
  env_hooker
  gemrc
  gitattributes
  gitconfig
  gitignore_global
  gvimrc
  inputrc
  irbrc
  pryrc
  terraformrc
  tmux-osx.conf
  tmux.conf
  vimrc
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

mkdir -p ~/.bashrc.d
for script_file in ~/dotfiles/bashrc.d/*; do
  script_name=$(basename "${script_file}")
  ln -sf "${script_file}" "${HOME}/.bashrc.d/${script_name}"
done

mkdir -p ~/bin
for script_file in ~/dotfiles/bin/*; do
  script_name=$(basename "${script_file}")
  ln -sf "${script_file}" "${HOME}/bin/${script_name}"
done
