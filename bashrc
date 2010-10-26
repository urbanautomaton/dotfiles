# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# make bash autocomplete with up arrow
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# make tab cycle through commands instead of listing
# bind '"\t":menu-complete' 

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_colored_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi



if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

alias my='mysql -u root'
alias mysqlstart='sudo /opt/local/bin/mysqld_safe5'
alias mysqlstop='/opt/local/bin/mysqladmin5 -u root -p shutdown'

alias c='ruby script/cucumber '
alias gv='/usr/bin/gvim'
alias my='mysql -u root --password=""'
alias ss='script/server --debugger'
alias ss1='script/server --debugger -p 3001'
alias ss2='script/server --debugger -p 3002'
alias sc='script/console' 
alias rl='source ~/.bashrc' 
alias pg='ps -awx | grep -i '
alias js='java org.mozilla.javascript.tools.shell.Main'
alias ll='ls -l'
alias fami='open ~/Design/fam/index_abc.png'
alias qa='ssh qa.v.mxmdev.com'

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[00;36m\]\w\[\033[00m\]\$ '

# OSX dependent stuff
case `uname` in
'Darwin')
# Mac specific settings
  alias vi='open -a MacVim.app'
  function edit()
  {
      /Applications/TextEdit.app/Contents/MacOS/TextEdit $@ 2>/dev/null
  }
  function nf()
  {
    grep -rin $@ ~/notes
  }
# End Mac specific settings
;;
'Linux')
# Linux specific settings
  alias vi='/usr/bin/vi'
# End Linux specific settings
;;
esac

if [[ `hostname` == sports ]]; then
  export RAILS_ENV=production
fi

if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

if [ -f ~/.git-completion ]; then
  . ~/.git-completion
fi

export PATH=$PATH:/usr/local/bin:~/scripts

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
