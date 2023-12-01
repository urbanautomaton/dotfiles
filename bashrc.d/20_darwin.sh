if [[ $(uname) == "Darwin" ]]; then
  ssh-add --apple-use-keychain -q

  if [[ -d "/opt/homebrew" ]]; then
    export HOMEBREW_PREFIX="/opt/homebrew";
  elif [[ -x "/usr/local/bin/brew" ]]; then
    export HOMEBREW_PREFIX="/usr/local";
  fi

  # This is the output of `brew shellenv` which they otherwise recommend you
  # eval as part of your bashrc. I've inlined it for faster terminal startup.
  if [[ -n "${HOMEBREW_PREFIX}" ]]; then
    export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
    export HOMEBREW_REPOSITORY=${HOMEBREW_PREFIX};
    export HOMEBREW_SHELLENV_PREFIX=${HOMEBREW_PREFIX};
    export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}";
    export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}";
  fi

  source_if_present "${HOMEBREW_PREFIX}/etc/bash_completion"
  source_if_present "${HOMEBREW_PREFIX}/share/chruby/chruby.sh"
  source_if_present "${HOMEBREW_PREFIX}/share/gem_home/gem_home.sh"

  if type -t chruby >/dev/null; then
    export CHRUBY_DEFAULT=2.7
    chruby $CHRUBY_DEFAULT
  fi

  ulimit -S -n 2048

  export BASH_SILENCE_DEPRECATION_WARNING=1
fi
