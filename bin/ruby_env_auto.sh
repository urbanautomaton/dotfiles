function chruby_default() {
  if [[ -n "$CHRUBY_DEFAULT" ]]; then
    chruby "$CHRUBY_DEFAULT"
  else
    chruby_reset
  fi
}

function ruby_env_auto() {
  local current_dir="$PWD"
  local version

  until [[ -z "$current_dir" ]]; do
		if { read -r version <"$current_dir/.ruby-version"; } 2>/dev/null; then
			if [[ "$version" == "$RUBY_AUTO_VERSION" ]]; then return
			else
				RUBY_AUTO_VERSION="$version"
				chruby "$version" && gem_home "$current_dir"
				return $?
			fi
    fi

    current_dir="${current_dir%/*}"
  done

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
