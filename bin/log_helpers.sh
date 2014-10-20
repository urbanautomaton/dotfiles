# Log helpers that colorize log output to stderr and stdout, and send output
# to the syslog with appropriate tags and severities.
#
# include in scripts for use:
# . ~/bin/log_helpers.sh

if ! type -t log >/dev/null; then
  : ${DATE_FORMAT:='%Y-%m-%dT%H:%M:%S%z'}
  readonly DATE_FORMAT
  readonly SCRIPT_NAME=$(basename $0)

  # Log in green if stdout is a color terminal
  if [[ -t 1 && $TERM =~ color ]]; then
    LOG_FORMAT='\x1B[0;32m[%s]: %s\x1B[0m\n'
  else
    LOG_FORMAT='[%s]: %s\n'
  fi
  readonly LOG_FORMAT

  # Error in red if stderr is a color terminal
  if [[ -t 2 && $TERM =~ color ]]; then
    ERR_FORMAT='\x1B[0;31m[%s]: %s\x1B[0m\n'
  else
    ERR_FORMAT='[%s]: %s\n'
  fi
  readonly ERR_FORMAT

  err() {
    printf "$ERR_FORMAT" $(date +"$DATE_FORMAT") "$@" >&2
    logger -p user.error -t $SCRIPT_NAME \""$@"\"
  }

  log() {
    printf "$LOG_FORMAT" $(date +"$DATE_FORMAT") "$@"
    logger -p user.notice -t $SCRIPT_NAME \""$@"\"
  }
fi
