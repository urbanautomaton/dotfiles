# vim:filetype=sh

alias rl='source ~/.bashrc'
alias pg='ps aux | egrep -i'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

ruby_command='puts RbConfig::CONFIG["configure_args"]'
alias rubyconf="ruby -r rbconfig -e '$ruby_command'"

alias be='bundle exec'

alias ls='ls -G'
alias ll='ls -lahF'

alias f='find . -name'
alias dircomp='diff -q -r'

alias rs='rsync -avz --partial --progress --rsh=ssh'

alias gs='git st'
alias gd='git d'
alias ga='git add'
alias gc='git checkout'
alias gl='git l'
alias bl='git l master..HEAD'

alias blog='workspace -n ua ~/dev/sites/urbanautomaton.com'
alias fix_terminal='stty echo icanon icrnl dsusp ^Y lnext ^V'

alias vi='vim'

# enable color support of ls and also add handy aliases
if [[ "$TERM" != "dumb" && -x /usr/bin/dircolors ]]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
