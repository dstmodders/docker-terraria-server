#!/usr/bin/env sh

debug="$DEBUG_ENTRYPOINT"

is_debug() {
  if [ "$debug" = '1' ]; then
    echo 1
  else
    echo 0
  fi
}

debug_echo() {
  if [ "$debug" = '1' ]; then
    echo "$@"
  fi
}

debug_printf() {
  if [ "$debug" = '1' ]; then
    # shellcheck disable=SC2059
    printf "$@"
  fi
}
