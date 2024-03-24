#!/usr/bin/env sh

get_first_char() {
  value="$1"
  echo "$value" | sed 's/^\(.\).*/\1/'
}

get_last_char() {
  value="$1"
  echo "$value" | sed 's/.*\(.\)$/\1/'
}

trim() {
  value="$1"
  result=$(printf '%s\n' "$value" | sed -e 's/^[[:space:]]*//') # leading spaces
  result=$(printf '%s\n' "$result" | sed -e 's/[[:space:]]*$//') # trailing spaces
  echo "$result"
}
