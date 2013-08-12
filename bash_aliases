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

alias ls='ls -G'

alias lsa='ls -laF'
alias ll='ls -l'

alias clean='mv $1 ~/clean/'
alias f='find . -name'

alias l='locate'

alias rs='rsync -avz --partial --progress --rsh=ssh'

alias gs='git s'
alias gd='git d'
alias ga='git add'
alias gc='git checkout'
alias gl='git l'
alias bl='git l master..HEAD'
alias gf='git commit -m "derp" && git rebase -i HEAD~2'
alias screen='TERM=screen screen'

alias couchstart='launchctl load -w ~/Library/LaunchAgents/org.apache.couchdb.plist'
alias couchstop='launchctl unload -w ~/Library/LaunchAgents/org.apache.couchdb.plist'

alias ss='workspace -d ~/dev/shopsearch -n ss -r mysql'
alias ts='workspace -d ~/dev/tribesports -n ts -r mysql'
alias td='workspace -d ~/dev/training_data -n training'
alias chef='workspace -d ~/dev/chef-repo -n chef'
alias pack='workspace -d ~/dev/packages -n pack'
alias blog='workspace -d ~/dev/urbanautomaton.com -n ua'
