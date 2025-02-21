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

for dir in $DOTDIRECTORIES; do
  if [[ ! -d "$dir" ]]; then
    echo "Symlinking: ${HOME}/dotfiles/${dir} => ${HOME}/.${dir}"
    $dircmd "${HOME}/dotfiles/${dir}" "${HOME}/.${dir}"
  else
    echo "    Exists: ${HOME}/.${dir}"
  fi
done

for file in $DOTFILES; do
  if [[ ! -f "$file" ]]; then
    echo "Symlinking: ${HOME}/dotfiles/${file} => ${HOME}/.${file}"
    ln -sf "${HOME}/dotfiles/${file}" "${HOME}/.${file}"
  else

    echo "    Exists: ${HOME}/.${file}"
  fi
done

mkdir -p ~/.bashrc.d
for script_file in ~/dotfiles/bashrc.d/*; do
  script_name=$(basename "${script_file}")
  if [[ ! -f "${script_file}" ]]; then
    echo "Symlinking: ${script_file} => ${HOME}/.bashrc.d/${script_name}"
    ln -sf "${script_file}" "${HOME}/.bashrc.d/${script_name}"
  else
    echo "    Exists: ${HOME}/.bashrc.d/${script_name}"
  fi
done

mkdir -p ~/bin
for script_file in ~/dotfiles/bin/*; do
  script_name=$(basename "${script_file}")
  if [[ ! -f "${script_file}" ]]; then
    echo "Symlinking: ${script_file} => ${HOME}/bin/${script_name}"
    ln -sf "${script_file}" "${HOME}/bin/${script_name}"
  else
    echo "    Exists: ${HOME}/bin/${script_name}"
  fi
done
