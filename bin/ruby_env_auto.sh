function chruby_default() {
  if [[ -n "$CHRUBY_DEFAULT" ]]; then
    chruby "$CHRUBY_DEFAULT"
  else
    chruby_reset
  fi
}

function ruby_env_reset_gc() {
  # Ruby 2.1 variables
  unset RUBY_GC_HEAP_INIT_SLOTS
  unset RUBY_GC_HEAP_FREE_SLOTS
  unset RUBY_GC_HEAP_GROWTH_FACTOR
  unset RUBY_GC_HEAP_GROWTH_MAX_SLOTS

  # Ruby < 2.1
  unset RUBY_HEAP_MIN_SLOTS
  unset RUBY_HEAP_SLOTS_INCREMENT
  unset RUBY_HEAP_SLOTS_GROWTH_FACTOR
  unset RUBY_GC_MALLOC_LIMIT
  unset RUBY_HEAP_FREE_MIN
}

function ruby_env_setup_gc() {
  # Slightly shonky version detection here, but sod it, how likely is ruby to
  # hit 2.10.0 without rolling over a major version?
  case $RUBY_VERSION in
    2.[1-9].[0-9])
      export RUBY_GC_HEAP_INIT_SLOTS=1200000
      export RUBY_GC_HEAP_FREE_SLOTS=100000
      export RUBY_GC_HEAP_GROWTH_FACTOR=1.25
      export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=300000
      ;;
    *)
      export RUBY_HEAP_MIN_SLOTS=1000000
      export RUBY_HEAP_SLOTS_INCREMENT=100000
      export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
      export RUBY_GC_MALLOC_LIMIT=100000000
      export RUBY_HEAP_FREE_MIN=500000
      ;;
  esac
}

function ruby_env_auto() {
  local current_dir="$PWD"
  local version

  until [[ -z "$current_dir" ]]; do
    if { read -r version <"$current_dir/.ruby-version"; } 2>/dev/null; then
      if [[ "$version" == "$RUBY_AUTO_VERSION" ]]; then return
      else
        [[ -n "$RUBY_GEMSET" ]] && gem_home -
        RUBY_AUTO_VERSION="$version"
        ruby_env_reset_gc
        chruby "$version"
        ruby_env_setup_gc
        if [[ -f "$current_dir/.gemset" ]]; then
          RUBY_GEMSET="$current_dir"
          gem_home "$RUBY_GEMSET"
          prepend_path $RUBY_GEMSET/.bin
        fi
        return
      fi
    fi

    current_dir="${current_dir%/*}"
  done

  if [[ -n "$RUBY_GEMSET" ]]; then
    remove_from_path "$RUBY_GEMSET/.bin"
    unset RUBY_GEMSET
    gem_home -
  fi

  if [[ -n "$RUBY_AUTO_VERSION" ]]; then
    unset RUBY_AUTO_VERSION
    chruby_default
  fi
}

if [[ -n "$ZSH_VERSION" ]]; then
  if [[ ! "$preexec_functions" == *ruby_env_auto* ]]; then
    preexec_functions+=("ruby_env_auto")
  fi
elif [[ -n "$BASH_VERSION" ]]; then
  trap '[[ "$BASH_COMMAND" != "$PROMPT_COMMAND" ]] && ruby_env_auto' DEBUG
fi
