function ruby_env_auto() {
  local current_dir="$PWD"
  local version_file

  until [[ -z "$current_dir" ]]; do
		if { read -r version <"$current_dir/.ruby-version"; } 2>/dev/null; then
			if [[ "$version" == "$RUBY_AUTO_VERSION" ]]; then return
			else
        echo "Setting up Ruby $version workspace in ${current_dir}..."
				RUBY_AUTO_VERSION="$version"
				chruby "$version" && gem_home "$current_dir"
				return $?
			fi
    fi

    current_dir="${current_dir%/*}"
  done

  if [[ -n "$RUBY_AUTO_VERSION" ]]; then
    echo "Resetting Ruby environment..."
    unset RUBY_AUTO_VERSION
    if [[ -n "$CHRUBY_DEFAULT" ]]; then
      chruby "$CHRUBY_DEFAULT"
    else
      chruby_reset
    fi
  fi
}

if [[ -n "$ZSH_VERSION" ]]; then
	if [[ ! "$preexec_functions" == *ruby_env_auto* ]]; then
		preexec_functions+=("ruby_env_auto")
	fi
else
	if [[ -n "$PROMPT_COMMAND" ]]; then
		if [[ ! "$PROMPT_COMMAND" == *ruby_env_auto* ]]; then
			PROMPT_COMMAND="$PROMPT_COMMAND; ruby_env_auto"
		fi
	else
		PROMPT_COMMAND="ruby_env_auto"
	fi
fi
