#!/usr/bin/env sh

validate_binary() {
  value="$1"
  case "$value" in
    0|1) echo 1 ;;
    *) echo 0 ;;
  esac
}

validate_matched() {
  value="$1"
  list="$2"
  for l in $list; do
    if [ "$value" = "$l" ]; then
      echo 1
      return
    fi
  done
  echo 0
}

validate_non_empty_string() {
  value="$1"
  if [ -n "$value" ]; then
    echo 1
  else
    echo 0
  fi
}

validate_path() {
  value="$1"

  if [ -z "$value" ]; then
    echo 0
    return
  fi

  if [ "$value" = '.' ] || [ "${value#./}" != "$value" ]; then
    echo 1
    return
  fi

  invalid_characters=$(echo "$value" | tr -d '[:alnum:] ./_-')
  if [ -n "$invalid_characters" ]; then
    echo 0
    return
  fi

  echo 1
}

validate_autocreate() {
  value="$1"
  case "$value" in
    1|2|3) echo 1 ;;
    *) echo 0 ;;
  esac
}

validate_difficulty() {
  value="$1"
  case "$value" in
    0|1|2|3) echo 1 ;;
    *) echo 0 ;;
  esac
}

validate_maxplayers() {
  value="$1"
  case "$value" in
    [1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]) echo 1 ;;
    *) echo 0 ;;
  esac
}

validate_npcstream() {
  value="$1"
  if [ "$value" -ge 0 ] 2>/dev/null; then
    echo 1
  else
    echo 0
  fi
}

validate_port() {
  value="$1"
  if [ "$value" -ge 1 ] 2>/dev/null && [ "$value" -le 65535 ] 2>/dev/null; then
    echo 1
  else
    echo 0
  fi
}

validate_priority() {
  value="$1"
  case "$value" in
    0|1|2|3|4|5) echo 1 ;;
    *) echo 0 ;;
  esac
}

validate_journeypermission() {
  value="$1"
  case "$value" in
    0|1|2) echo 1 ;;
    *) echo 0 ;;
  esac
}

validate_announcementboxrange() {
  value="$1"
  if [ "$value" -eq -1 ] 2>/dev/null || [ "$value" -gt 0 ] 2>/dev/null; then
    echo 1
  else
    echo 0
  fi
}

validate_ip() {
  value="$1"
  regex="^([0-9]{1,3}\.){3}[0-9]{1,3}$"
  if echo "$value" | grep -Eq "$regex"; then
    octets=$(echo "$value" | tr '.' '\n')
    for octet in $octets; do
      if [ "$octet" -gt 255 ] || [ "$octet" -lt 0 ]; then
        echo 0
        return
      fi
    done
    echo 1
  else
    echo 0
  fi
}

validate_lobby() {
  value="$1"
  case "$value" in
    friends|private) echo 1 ;;
    *) echo 0 ;;
  esac
}
