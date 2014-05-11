# vim:filetype=sh

alias gv='/usr/bin/gvim'
alias sc='pry'
alias rl='source ~/.bashrc'
alias pg='ps aux | egrep -i'

alias grep='egrep --color=auto'
alias fgrep='egrep --color=auto'
alias egrep='egrep --color=auto'

ruby_command='puts Config::CONFIG["configure_args"]'
alias rubyconf="ruby -r rbconfig -e '$ruby_command'"

alias be='bundle exec'

alias ls='ls -G'
alias ll='ls -alF'
alias l='ls -l'

alias clean='mv $1 ~/clean/'
alias f='find . -name'
alias dircomp='diff -q -r'

alias rs='rsync -avz --partial --progress --rsh=ssh'

alias gs='git st'
alias gd='git d'
alias ga='git add'
alias gc='git checkout'
alias gl='git l'
alias bl='git l master..HEAD'

alias screen='TERM=screen screen'

alias couchstart='launchctl load -w ~/Library/LaunchAgents/org.apache.couchdb.plist'
alias couchstop='launchctl unload -w ~/Library/LaunchAgents/org.apache.couchdb.plist'

alias ts='workspace -n ts -d mysql ~/dev/tribesports'
alias po='workspace -n po ~/dev/poncho'
alias cts='workspace ~/dev/chef-tribesports'
alias ctp='workspace ~/dev/chef-poncho'
alias pack='workspace -n pack ~/dev/packages'
alias blog='workspace -n ua ~/dev/urbanautomaton.com'
