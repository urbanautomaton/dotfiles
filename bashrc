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
  xterm-256color) color_prompt=yes;;
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
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1)\$ '
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

# OSX dependent stuff
case `uname` in
'Darwin')
# Mac specific settings
  alias git='hub'
  alias vi='open -a MacVim.app'
  export EDITOR="mvim -f"
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

function tabc {
    NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi
    osascript -e "tell application \"Terminal\" to set current settings of front window to settings set \"$NAME\""
}

function ssh-terminal-app {
  ORIGINAL_SETTINGS=`osascript -e "tell application \"Terminal\" to get name of current settings of front window"`
  tabc "Red"
  /usr/bin/ssh "$@"
  tabc "$ORIGINAL_SETTINGS"
}

function iterm2-dark {
  osascript -e "
    tell application \"iTerm 2\"
      tell current terminal
        tell session id \"$1\"
          set background color to {0, 7723, 9942}
          set bold color to {33161, 37019, 36938}
          set cursor color to {28874, 33399, 33873}
          set cursor_text color to {0, 10208, 12694}
          set foreground color to {28874, 33399, 33873}
          set selected text color to {33161, 37019, 36938}
          set selection color to {0, 10208, 12694}
        end tell
      end tell
    end tell
  "
}

function iterm2-light {
  osascript -e "
    tell application \"iTerm 2\"
      tell current terminal
        tell session id \"$1\"
          set background color to {64843, 62779, 56627}
          set bold color to {18135, 23374, 25099}
          set cursor color to {21257, 26684, 28737}
          set cursor_text color to {60038, 58327, 52285}
          set foreground color to {21257, 26684, 28737}
          set selected text color to {18135, 23374, 25099}
          set selection color to {60038, 58327, 52285}
        end tell
      end tell
    end tell
  "
}

function ssh-iterm2 {
  local tty=$(tty)
  iterm2-light "$tty"
  /usr/bin/ssh "$@"
  iterm2-dark "$tty"
}

function ssh {
  if [[ -n "$ITERM_SESSION_ID" ]]; then
    ssh-iterm2 "$@"
  else
    ssh-terminal-app "$@"
  fi
}


export EC2_HOME=$HOME/.ec2
export EC2_PRIVATE_KEY=$EC2_HOME/pk-23AHI74KQ3OGF4W7ZDQIPH6ETKPEJTHF.pem
export EC2_CERT=$EC2_HOME/cert-23AHI74KQ3OGF4W7ZDQIPH6ETKPEJTHF.pem
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
export EC2_URL=https://ec2.us-west-1.amazonaws.com

#export GIT_PS1_SHOWDIRTYSTATE=1

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:~/scripts:$EC2_HOME/bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
