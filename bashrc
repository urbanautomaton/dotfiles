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

# If this is an interactive shell...
case "$-" in
  *i*)
    # ...make bash autocomplete with up arrow
    bind '"\e[A":history-search-backward'
    bind '"\e[B":history-search-forward'
    bind '"\M-d":backward-kill-word'
esac

function append_path() {
  if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="${PATH:+"$PATH:"}$1"
  fi
}

function prepend_path() {
  if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1${PATH:+":$PATH"}"
  fi
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
    prepend_path $JAVA_HOME
    function edit()
    {
      /Applications/TextEdit.app/Contents/MacOS/TextEdit $@ 2>/dev/null
    }
    append_path ~/android/sdk/tools
    append_path ~/android/sdk/platform-tools
    append_path /usr/local/mysql/bin
    append_path /usr/local/packer
    append_path /opt/pear/bin
    append_path /usr/texbin
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

# AWS toolkit variables
export EC2_HOME=$HOME/.ec2
export EC2_PRIVATE_KEY=$EC2_HOME/pk-23AHI74KQ3OGF4W7ZDQIPH6ETKPEJTHF.pem
export EC2_CERT=$EC2_HOME/cert-23AHI74KQ3OGF4W7ZDQIPH6ETKPEJTHF.pem
export EC2_URL=https://ec2.us-west-1.amazonaws.com

# Visible cucumber step locations
export CUCUMBER_COLORS=comment=cyan

append_path $HOME/bin
append_path $EC2_HOME/bin
append_path /usr/local/sbin

chruby_location=/usr/local/share/chruby/chruby.sh
gem_home_location=/usr/local/share/gem_home/gem_home.sh
ruby_env_auto_location=~/bin/ruby_env_auto.sh

if [[ -f "$chruby_location" ]]; then
  export CHRUBY_DEFAULT=2.0.0
  readonly CHRUBY_DEFAULT

  source $chruby_location
  chruby $CHRUBY_DEFAULT

  if [[ -f "$gem_home_location" ]]; then
    source $gem_home_location

    if [[ -f "$ruby_env_auto_location" ]]; then
      source $ruby_env_auto_location
    fi
  fi
fi
