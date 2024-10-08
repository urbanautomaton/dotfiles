# shellcheck shell=bash

##############
# Misc shell #
##############

# Use funky extended bash globbing:
# http://www.linuxjournal.com/content/bash-extended-globbing
shopt -s extglob
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

if [[ -d ~/.bashrc.d ]]; then
  for file in ~/.bashrc.d/*; do
    # shellcheck disable=SC1090
    source "${file}"
  done
fi

#########################
# Custom PATH locations #
#########################

append_path_if_present "$HOME/bin"
append_path_if_present /usr/local/sbin

######################
# Terminal wrangling #
######################

# set a fancy prompt
# Visible cucumber step locations
export CUCUMBER_COLORS=comment=cyan

export NVM_DIR="${HOME}/.nvm"
source_if_present "${NVM_DIR}/nvm.sh"
source_if_present "${NVM_DIR}/bash_completion"

################
# And the rest #
################

source_if_present ~/.bashrc.local

# Enable programmable bash command-line completion (Debian derivs)
source_if_present /etc/bash_completion

# Load environment hook scripts
source_if_present ~/.env_hooker

if [[ -d ~/.env_hooks ]]; then
  for file in ~/.env_hooks/*; do
    # shellcheck disable=SC1090
    source "$file"
  done
fi

# Start a flame war
export EDITOR="vim"

# FU Spring
export DISABLE_SPRING=true

if [[ -f "${HOME}/.gemrc.local" ]]; then
  export GEMRC="${HOME}/.gemrc.local"
fi

prepend_path_if_present "${HOME}/.cargo/bin"
