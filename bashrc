###########
# HISTORY #
###########

# Ignore duplicate commands, space-prefixed, and misc boring cmds.
export HISTIGNORE="&:[ ]*:exit:gs:gl"
# Massive main .bash_history...
export HISTFILESIZE=10000
# Larger session histories...
export HISTSIZE=1000
# And don't overwrite .bash_history on exit
shopt -s histappend
# Use funky extended bash globbing:
# http://www.linuxjournal.com/content/bash-extended-globbing
shopt -s extglob

# If this is an interactive shell...
case "$-" in
  *i*)
    # ...make bash autocomplete with up arrow
    bind '"\e[A":history-search-backward'
    bind '"\e[B":history-search-forward'
    bind '"\M-d":backward-kill-word'
esac

function append_path_if_present() {
  if [[ -d "$1" ]]; then
    append_path "$1"
  fi
}

function prepend_path_if_present() {
  if [[ -d "$1" ]]; then
    prepend_path "$1"
  fi
}

function append_path() {
  if [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="${PATH:+"$PATH:"}$1"
  fi
}

function prepend_path() {
  if [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1${PATH:+":$PATH"}"
  fi
}

function remove_from_path() {
  local readonly remove=$1
  local work=:$PATH:
  work=${work/:$remove:/:}
  work=${work#:}
  work=${work%:}
  export PATH=$work
}

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt
if [[ "$TERM" =~ color ]]; then
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1) \$ '
else
  PS1='\u@\h:\w\$ '
fi

# If this is an xterm set the title to user@host:dir
if [[ "$TERM" =~ xterm*|rxvt* ]]; then
  PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
fi

# Alias definitions
if [[ -f ~/.bash_aliases ]]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [[ "$TERM" != "dumb" && -x /usr/bin/dircolors ]]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [[ -f /etc/bash_completion ]]; then
  . /etc/bash_completion
fi

# OSX dependent stuff
case `uname` in
  # Mac Specific
  'Darwin')
    export EDITOR="vim"
    if [[ ! "DYLD_LIBRARY_PATH" =~ /usr/local/mysql/lib ]]; then
      export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
    fi
    export JAVA_HOME=$(/usr/libexec/java_home)
    prepend_path_if_present $JAVA_HOME
    function edit()
    {
      /Applications/TextEdit.app/Contents/MacOS/TextEdit $@ 2>/dev/null
    }
    append_path_if_present ~/android/sdk/tools
    append_path_if_present ~/android/sdk/platform-tools
    append_path_if_present /usr/local/mysql/bin
    append_path_if_present /usr/local/packer
    append_path_if_present /opt/pear/bin
    append_path_if_present /usr/texbin
    append_path_if_present /usr/local/heroku/bin
    export EC2_HOME=/opt/ec2
    append_path_if_present /opt/ec2/bin
    ulimit -S -n 2048
    export VAGRANT_DEFAULT_PROVIDER=vmware_fusion
    ;;
  # Linux Specific
  'Linux')
    alias vi='vim'
    ;;
esac

# Host-specific bashrc if present
if [[ -f ~/.bashrc.local ]]; then
  . ~/.bashrc.local
fi

if [[ -f ~/.git-completion ]]; then
  . ~/.git-completion
fi

# Visible cucumber step locations
export CUCUMBER_COLORS=comment=cyan

append_path_if_present $HOME/bin
append_path_if_present /usr/local/sbin
append_path_if_present /usr/local/go/bin

chruby_location=/usr/local/share/chruby/chruby.sh
gem_home_location=/usr/local/share/gem_home/gem_home.sh
ruby_env_auto_location=~/bin/ruby_env_auto.sh
go_env_auto_location=~/bin/go_env_auto.sh
env_handlers=""

function add_env_handler() {
  local handler=$1
  if [[ -n "$env_handlers" ]]; then
    env_handlers="$env_handlers && $handler"
  else
    env_handlers=$handler
  fi
}

if [[ -f "$chruby_location" ]]; then
  export CHRUBY_DEFAULT=2.0.0
  readonly CHRUBY_DEFAULT

  source $chruby_location
  chruby $CHRUBY_DEFAULT

  if [[ -f "$gem_home_location" ]]; then
    source $gem_home_location

    if [[ -f "$ruby_env_auto_location" ]]; then
      source $ruby_env_auto_location
      add_env_handler ruby_env_auto
    fi
  fi
fi

if [[ -f "$go_env_auto_location" ]]; then
  source $go_env_auto_location
  add_env_handler go_env_auto
fi

if [[ -n "$ZSH_VERSION" ]]; then
  if [[ ! "$preexec_functions" == *ruby_env_auto* ]]; then
    preexec_functions+=("$env_handlers")
  fi
elif [[ -n "$BASH_VERSION" ]]; then
  prompt_test='[[ "$BASH_COMMAND" != "$PROMPT_COMMAND" ]]'
  trap "$prompt_test && $env_handlers" DEBUG
fi
