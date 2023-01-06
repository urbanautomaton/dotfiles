function source_if_present() {
  # This warning complains about a non-constant source location, but that's
  # the point of this function, so. What're you gonna do eh?
  #
  # shellcheck disable=SC1090
  [[ -s "$1" ]] && source "$1"
}

function path_contains() {
  [[ ":$PATH:" == *":$1:"* ]]
}

function directory_exists() {
  [[ -d "$1" ]]
}

function command_exists() {
  type -t "$1" >/dev/null
}

function append_path() {
  path_contains "$1" || export PATH="${PATH:+"$PATH:"}$1"
}

function prepend_path() {
  path_contains "$1" || export PATH="$1${PATH:+":$PATH"}"
}

function append_path_if_present() {
  directory_exists "$1" && append_path "$1"
}

function prepend_path_if_present() {
  directory_exists "$1" && prepend_path "$1"
}

function append_prompt_command() {
  PROMPT_COMMAND=${PROMPT_COMMAND:+"${PROMPT_COMMAND}; "}$1
}

function remove_from_path() {
  local -r remove="$1"
  local work=:$PATH:
  work=${work/:$remove:/:}
  work=${work#:}
  work=${work%:}
  export PATH=$work
}

function check_args() {
  local args=("$@")
  local arg
  local arg_num

  echo "\$0: \"${0}\""
  for i in "${!args[@]}"; do
    arg=${args[$i]}
    ((arg_num=i+1))
    echo "\$${arg_num}: \"${arg}\""
  done
}
