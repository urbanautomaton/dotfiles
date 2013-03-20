function chgems_auto() {
	local dir="$PWD"
	local version_file

	until [[ -z "$dir" ]]; do
		gemset_file="$dir/.gemset"

		if   [[ "$gemset_file" == "$RUBY_GEMSET_FILE" ]]; then return
		elif [[ -f "$gemset_file" ]]; then
			export RUBY_GEMSET_FILE="$gemset_file"
      chgems
			return
		fi

		dir="${dir%/*}"
	done
}

if [[ -n "$ZSH_VERSION" ]]; then
	if [[ ! "$precmd_functions" == *chgems_auto* ]]; then
		precmd_functions+=("chgems_auto")
	fi
else
	if [[ -n "$PROMPT_COMMAND" ]]; then
		if [[ ! "$PROMPT_COMMAND" == *chgems_auto* ]]; then
			PROMPT_COMMAND="$PROMPT_COMMAND; chgems_auto"
		fi
	else
		PROMPT_COMMAND="chgems_auto"
	fi
fi
