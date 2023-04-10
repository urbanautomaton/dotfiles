alias rl='source ~/.bashrc'
alias pg='ps aux | egrep -i'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias rubyconf="ruby -r rbconfig -e 'puts RbConfig::CONFIG[\"configure_args\"]'"

alias be='bundle exec'
alias genri='gem rdoc --all --ri --no-rdoc'

alias ls='ls -G'
alias ll='ls -lahF'

alias f='find . -name'
alias dircomp='diff -q -r'

alias rs='rsync -avz --partial --progress --rsh=ssh'

alias gs='git st'
alias ga='git add'
alias gd='git diff'

alias ws='workspace'
alias blog='workspace -n ua ~/dev/sites/urbanautomaton.com'
alias fl='workspace -d "mysql -u root -D futurelearn_development --host 127.0.0.1" ~/dev/futurelearn/futurelearn'
alias fix_terminal='stty echo icanon icrnl dsusp ^Y lnext ^V'

alias ci="hub ci-status -v \`git rev-parse --abbrev-ref HEAD\` | grep jenkins.futurelearn.dev | cut -f3 | xargs open -a /Applications/Google\ Chrome.app"

alias ffs='bundle && yarn install && rake db:migrate'

alias jest_debug='node --inspect-brk node_modules/.bin/jest --runInBand'

alias vi='vim'

# enable color support of ls and also add handy aliases
if [[ "$TERM" != "dumb" && -x /usr/bin/dircolors ]]; then
  eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias jest_debug='node --inspect-brk node_modules/.bin/jest --runInBand'

jqp() {
  echo '' | fzf --preview "jq {q} < ${1}"
}
