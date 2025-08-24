#!/bin/bash

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
  bash_completion
  bashrc
  env_hooker
  gemrc
  gitattributes
  gitconfig
  gitignore_global
  inputrc
  irbrc
  npmrc
  pryrc
  terraformrc
  tmux-osx.conf
  tmux.conf
  vimrc
"

echo "doing directories"
for dir in $DOTDIRECTORIES; do
  dest="${HOME}/.${dir}"

  if [[ ! -d "$dest" ]]; then
    echo "Symlinking: ${HOME}/dotfiles/${dir} => ${dest}"
    $dircmd "${HOME}/dotfiles/${dir}" "${dest}"
  else
    echo "    Exists: ${HOME}/.${dir}"
  fi
done

echo "doing files"
for file in $DOTFILES; do
  dest="${HOME}/.${file}"

  if [[ ! -f "$dest" ]]; then
    echo "Symlinking: ${HOME}/dotfiles/${file} => ${dest}"
    ln -sf "${HOME}/dotfiles/${file}" "${dest}"
  else

    echo "    Exists: ${HOME}/.${file}"
  fi
done

echo "doing bashrc.d"
mkdir -p ~/.bashrc.d
for script_file in ~/dotfiles/bashrc.d/*; do
  script_name=$(basename "${script_file}")
  dest="${HOME}/.bashrc.d/${script_name}"

  if [[ ! -f "${dest}" ]]; then
    echo "Symlinking: ${script_file} => ${dest}"
    ln -sf "${script_file}" "${dest}"
  else
    echo "    Exists: ${HOME}/.bashrc.d/${script_name}"
  fi
done

echo "doing bin"
mkdir -p ~/bin
for script_file in ~/dotfiles/bin/*; do
  script_name=$(basename "${script_file}")
  destination="${HOME}/bin/${script_name}"
  if [[ ! -f "${destination}" ]]; then
    echo "Symlinking: ${script_file} => ${HOME}/bin/${script_name}"
    ln -sf "${script_file}" "${destination}"
  else
    echo "    Exists: ${HOME}/bin/${script_name}"
  fi
done
