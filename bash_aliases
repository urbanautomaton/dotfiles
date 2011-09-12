alias gv='/usr/bin/gvim'
alias ss='rails_server.sh'
alias sc='rails_console.sh'
alias rl='source ~/.bashrc'
alias pg='ps aux | egrep -i'

alias ls='ls -G'

alias lsa='ls -laF'
alias ll='ls -l'

alias clean='mv $1 ~/clean/'
alias f='find . -name'

alias l='locate'

alias rs='rsync -avz --partial --progress --rsh=ssh'

alias gs='git status -sb'
alias gd='git diff --word-diff'
alias ga='git add'
alias gc='git checkout'
alias gl='git log --graph --pretty=oneline --abbrev-commit'
alias screen='TERM=screen screen'

alias couchstart='launchctl load -w ~/Library/LaunchAgents/org.apache.couchdb.plist'
alias couchstop='launchctl unload -w ~/Library/LaunchAgents/org.apache.couchdb.plist'
