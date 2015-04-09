function remove_from_path() {
  local readonly remove=$1
  local work=:$PATH:
  work=${work/:$remove:/:}
  work=${work#:}
  work=${work%:}
  export PATH=$work
}

function go_env_auto() {
  local current_dir="$PWD"

  until [[ -z "$current_dir" ]]; do
    if [[ -f "$current_dir/.goworkspace" ]]; then
      [[ "$GOPATH_AUTO" == "$current_dir" ]] && return

      echo "Setting GOPATH to $current_dir"
      GOPATH_AUTO=$current_dir
      export GOPATH=$current_dir
      export PATH=$PATH:$GOPATH/bin
      return
    fi

    current_dir="${current_dir%/*}"
  done

  if [[ -n "$GOPATH_AUTO" ]]; then
    echo "Unsetting GOPATH"
    [[ -n "$GOPATH" ]] && remove_from_path $GOPATH/bin
    unset GOPATH_AUTO
    unset GOPATH
  fi
}
