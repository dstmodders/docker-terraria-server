#!/usr/bin/env sh

trim() {
  value="$1"
  result=$(printf '%s\n' "$value" | sed -e 's/^[[:space:]]*//') # leading spaces
  result=$(printf '%s\n' "$result" | sed -e 's/[[:space:]]*$//') # trailing spaces
  echo "$result"
}
