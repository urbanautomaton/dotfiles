function enter_goworkspace {
  readonly local current_dir=$1

  [[ "$GOPATH_AUTO" == "${current_dir}" ]] && return

  GOPATH_AUTO=${current_dir}
  export GOPATH=${current_dir}
  append_path $GOPATH/bin
}

function exit_goworkspace {
  if [[ -n "$GOPATH_AUTO" ]]; then
    [[ -n "$GOPATH" ]] && remove_from_path $GOPATH/bin
    unset GOPATH_AUTO
    unset GOPATH
  fi
}

function go_env_auto() {
  local current_dir="$PWD"

  until [[ -z "${current_dir}" ]]; do
    if [[ -f "${current_dir}/.goworkspace" ]]; then
      enter_goworkspace ${current_dir}
      return
    fi

    current_dir="${current_dir%/*}"
  done

  exit_goworkspace
}
