function go_env_auto() {
  local current_dir="$PWD"

  until [[ -z "$current_dir" ]]; do
    if [[ -f "$current_dir/.goworkspace" ]]; then
      [[ "$GOPATH_AUTO" == "$current_dir" ]] && return

      GOPATH_AUTO=$current_dir
      export GOPATH=$current_dir
      append_path $GOPATH/bin
      return
    fi

    current_dir="${current_dir%/*}"
  done

  if [[ -n "$GOPATH_AUTO" ]]; then
    [[ -n "$GOPATH" ]] && remove_from_path $GOPATH/bin
    unset GOPATH_AUTO
    unset GOPATH
  fi
}
