alias gv='/usr/bin/gvim'
alias sc='pry'
alias rl='source ~/.bashrc'
alias pg='ps aux | egrep -i'

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
alias gl='git l -n 20'
alias bl='git l master..HEAD'
alias gf='git commit -m "derp" && git rebase -i HEAD~2'
alias screen='TERM=screen screen'

alias couchstart='launchctl load -w ~/Library/LaunchAgents/org.apache.couchdb.plist'
alias couchstop='launchctl unload -w ~/Library/LaunchAgents/org.apache.couchdb.plist'

alias ss='workspace_with_db shopsearch ss'
alias ts='workspace_with_db tribesports ts'
alias ws='workspace_with_db wordsmith ws'
alias derp='workspace_with_pg_db derp'
alias td='workspace training_data td'
alias chef='workspace chef-repo chef'
alias pack='workspace packages pack'
