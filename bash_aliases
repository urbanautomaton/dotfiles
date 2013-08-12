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

alias ss='workspace ~/dev/shopsearch ss mysql'
alias ts='workspace ~/dev/tribesports ts mysql'
alias ws='workspace ~/dev/wordsmith ws mysql'
alias derp='workspace ~/dev/derp derp pg'
alias td='workspace ~/dev/training_data training'
alias chef='workspace ~/dev/chef-repo chef'
alias pack='workspace ~/dev/packages pack'
alias blog='workspace ~/dev/urbanautomaton.com ua'
