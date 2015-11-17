function chruby_default() {
  if [[ -n "$CHRUBY_DEFAULT" ]]; then
    chruby "$CHRUBY_DEFAULT"
  else
    chruby_reset
  fi
}

function enter_ruby_version {
  readonly local current_dir=$1
  local version
  local gem_dir

  if { read -r version <"${current_dir}/.ruby-version"; } 2>/dev/null; then
    chruby "${version}"
    RUBY_AUTO_VERSION="${version}"

    if [[ -f "${current_dir}/.gemset" ]]; then
      gem_dir=${current_dir//\//\%}
      gem_dir=${gem_dir// /_}
      gem_dir="${HOME}/.gem/gemsets/${gem_dir}"
      RUBY_GEMSET="${gem_dir}"
      gem_home "${RUBY_GEMSET}"
      prepend_path ${current_dir}/.bin
    fi
  fi
}

function exit_ruby_version {
  if [[ -n "${RUBY_GEMSET}" ]]; then
    remove_from_path "${RUBY_GEMSET}/.bin"
    unset RUBY_GEMSET
    gem_home -
  fi

  if [[ -n "${RUBY_AUTO_VERSION}" ]]; then
    unset RUBY_AUTO_VERSION
    chruby_default
  fi
}

function ruby_env_auto() {
  local current_dir="$PWD"

  until [[ -z "${current_dir}" ]]; do
    if [[ -f "${current_dir}/.ruby-version" ]]; then
      enter_ruby_version ${current_dir}
      return
    fi

    current_dir="${current_dir%/*}"
  done

  exit_ruby_version
}
