# Ignore duplicate commands, space-prefixed, and misc boring cmds.
export HISTIGNORE="&:[ ]*:exit:gs:gl:ll"
# Unlimited history size
export HISTFILESIZE=
export HISTSIZE=
# Nice timestamps...
HISTTIMEFORMAT='[%F %T] '
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Save multi-line commands as one command...
shopt -s cmdhist
# Save commands as they're issued...
append_prompt_command 'history -a'
# And don't overwrite .bash_history on exit
shopt -s histappend
