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
