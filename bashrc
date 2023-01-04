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

###########
# HISTORY #
###########

# Ignore duplicate commands, space-prefixed, and misc boring cmds.
export HISTIGNORE="&:[ ]*:exit:gs:gl:ll"
# Massive main .bash_history...
export HISTFILESIZE=10000
# Larger session histories...
export HISTSIZE=1000
# Nice timestamps...
HISTTIMEFORMAT='%F %T '
# Save multi-line commands as one command...
shopt -s cmdhist
# Save commands as they're issued...
append_prompt_command 'history -a'
# And don't overwrite .bash_history on exit
shopt -s histappend

#########################
# Custom PATH locations #
#########################

append_path_if_present "$HOME/bin"
append_path_if_present /usr/local/sbin

######################
# Terminal wrangling #
######################

# set a fancy prompt
PROMPT_DIRTRIM=2
if [[ "$TERM" =~ color ]]; then
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1) \$ '
else
  PS1='\u@\h:\w\$ '
fi

export GIT_PS1_SHOWDIRTYSTATE=1

# If this is an xterm set the title to user@host:dir
if [[ "$TERM" =~ xterm*|rxvt* ]]; then
  # This warning complains about the single quotes wrapping a string with
  # apparent string interpolations - however it's that way around precisely to
  # stop the interpolations happening at bashrc runtime.
  #
  # shellcheck disable=SC2016
  append_prompt_command 'echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
fi

# Visible cucumber step locations
export CUCUMBER_COLORS=comment=cyan

export NVM_DIR="${HOME}/.nvm"
source_if_present "${NVM_DIR}/nvm.sh"
source_if_present "${NVM_DIR}/bash_completion"

################
# And the rest #
################

source_if_present ~/.bash_aliases
source_if_present ~/.bashrc.darwin
source_if_present ~/.bashrc.local

# Enable programmable bash command-line completion (Debian derivs)
source_if_present /etc/bash_completion

# Load custom completions
source_if_present ~/.bash_completion

# Load environment hook scripts
source_if_present ~/.env_hooker

source_if_present ~/.env_hooks/ruby
source_if_present ~/.env_hooks/node
source_if_present ~/.env_hooks/golang

# Start a flame war
export EDITOR="vim"

prepend_path_if_present "${HOME}/.cargo/bin"
