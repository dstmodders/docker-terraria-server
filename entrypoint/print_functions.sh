#!/usr/bin/env sh

functions_dirname=$(dirname "$0")
if [ -n "$FUNCTIONS_DIRNAME" ]; then
  functions_dirname="$FUNCTIONS_DIRNAME"
fi

. "$functions_dirname/general_functions.sh"
. "$functions_dirname/validate_functions.sh"

print_bold() {
  value="$1"
  if [ "$DISABLE_COLORS" = '1' ] || ! [ -t 0 ]; then
    printf "%s" "$value"
  else
    printf "$(tput bold)%s$(tput sgr0)" "$value"
  fi
}

print_bold_red() {
  value="$1"
  if [ "$DISABLE_COLORS" = '1' ] || ! [ -t 0 ]; then
    printf "%s" "$value"
  else
    printf "$(tput bold)$(tput setaf 1)%s$(tput sgr0)" "$value"
  fi
}

print_invalid_value() {
  value="$1"
  printf "%s %s" "$value" "$(print_bold_red '(invalid)')"
}

print_value() {
  value="$1"
  validate_function="$2"
  is_optional="$3"
  case "$value" in
    '')
      if [ "$is_optional" = '1' ]; then
        echo '- (empty)'
      else
        print_invalid_value '-'
      fi
    ;;
    *)
      if [ "$("$validate_function" "$value")" -eq 1 ]; then
        printf "%s" "$value"
      else
        print_invalid_value "$value"
      fi
      ;;
  esac
}

print_binary_value() {
  value="$1"
  is_optional="$2"
  case "$value" in
    '')
      if [ "$is_optional" = '1' ]; then
        echo '- (empty)'
      else
        print_invalid_value '-'
      fi
    ;;
    0) printf "%s (disabled)" "$value" ;;
    1) printf "%s (enabled)" "$value" ;;
    *)
      if [ "$(validate_binary "$value")" -eq 1 ]; then
        printf "%s" "$value"
      else
        print_invalid_value "$value"
      fi
      ;;
  esac
}

print_matched_value() {
  value="$1"
  list="$2"
  is_optional="$3"
  case "$value" in
    '')
      if [ "$is_optional" = '1' ]; then
        echo '- (empty)'
      else
        print_invalid_value '-'
      fi
    ;;
    *)
      if [ "$(validate_matched "$value" "$list")" -eq 1 ]; then
        printf "%s" "$value"
      else
        print_invalid_value "$value"
      fi
      ;;
  esac
}

print_path_value() {
  print_value "$1" 'validate_path' "$2"
}

print_string_value() {
  value="$1"
  is_optional="$2"
  if [ -z "$1" ]; then
    if [ "$is_optional" = '1' ]; then
      echo '- (empty)'
    else
      print_invalid_value '-'
    fi
  else
    echo "$value"
  fi
}

print_autocreate_value() {
  value="$1"
  case "$value" in
    '') print_invalid_value '-' ;;
    1) printf "%s (small)" "$value" ;;
    2) printf "%s (medium)" "$value" ;;
    3) printf "%s (large)" "$value" ;;
    *)
      if [ "$(validate_autocreate "$value")" -eq 1 ]; then
        printf "%s" "$value"
      else
        print_invalid_value "$value"
      fi
      ;;
  esac
}

print_difficulty_value() {
  value="$1"
  case "$value" in
    '') print_invalid_value '-' ;;
    0) printf "%s (normal)" "$value" ;;
    1) printf "%s (expert)" "$value" ;;
    2) printf "%s (master)" "$value" ;;
    3) printf "%s (journey)" "$value" ;;
    *)
      if [ "$(validate_difficulty "$value")" -eq 1 ]; then
        printf "%s" "$value"
      else
        print_invalid_value "$value"
      fi
      ;;
  esac
}

print_maxplayers_value() {
  value="$1"
  case "$value" in
    '') print_invalid_value '-' ;;
    *)
      if [ "$(validate_maxplayers "$value")" -eq 1 ]; then
        printf "%s" "$value"
      else
        print_invalid_value "$value"
      fi
      ;;
  esac
}

print_npcstream_value() {
  value="$1"
  case "$value" in
    '') print_invalid_value '-' ;;
    *)
      if [ "$(validate_npcstream "$value")" -eq 1 ]; then
        printf "%s" "$value"
      else
        print_invalid_value "$value"
      fi
      ;;
  esac
}

print_port_value() {
  value="$1"
  case "$value" in
    '') print_invalid_value '-' ;;
    *)
      if [ "$(validate_port "$value")" -eq 1 ]; then
        printf "%s" "$value"
      else
        print_invalid_value "$value"
      fi
      ;;
  esac
}

print_priority_value() {
  value="$1"
  is_optional="$2"
  case "$value" in
    '')
      if [ "$is_optional" = '1' ]; then
        echo '- (empty)'
      else
        print_invalid_value '-'
      fi
    ;;
    0) printf "%s (realtime)" "$value" ;;
    1) printf "%s (high)" "$value" ;;
    2) printf "%s (above normal)" "$value" ;;
    3) printf "%s (normal)" "$value" ;;
    4) printf "%s (below normal)" "$value" ;;
    5) printf "%s (idle)" "$value" ;;
    *)
      if [ "$(validate_priority "$value")" -eq 1 ]; then
        printf "%s" "$value"
      else
        print_invalid_value "$value"
      fi
      ;;
  esac
}

print_journeypermission_value() {
  value="$1"
  case "$1" in
    '') print_invalid_value '-' ;;
    0) printf "%s (locked for everyone)" "$value" ;;
    1) printf "%s (can only be changed by host)" "$value" ;;
    2) printf "%s (can be changed by everyone)" "$value" ;;
    *)
      if [ "$(validate_journeypermission "$value")" -eq 1 ]; then
        printf "%s" "$value"
      else
        print_invalid_value "$value"
      fi
      ;;
  esac
}

print_announcementboxrange_value() {
  print_value "$1" 'validate_announcementboxrange' 1
}

print_ip_value() {
  print_value "$1" 'validate_ip' 1
}

print_lobby_value() {
  print_value "$1" 'validate_lobby' 1
}

print_command() {
  value="$1"
  total_spaces="$2"
  if [ -z "$total_spaces" ]; then
    total_spaces=2
  fi
  spaces="$(printf "%*s" "$total_spaces" '')"

  result=""
  count=0
  total="$(echo "$value" | wc -w)"
  quote_start=''

  for arg in $value; do
    count="$((count + 1))"
    case "$arg" in
      -secure|-noupnp|-steam|-disableannouncementbox|-ignoreversion|-forceupdate|-autoshutdown|-secure|-logclear|-dump|-heaptile|-constileation|-c)
        quote_start=''
        result="$(printf "%s\n%s%s" "$result" "$spaces" "$arg")"
        if [ "$count" -ne "$total" ]; then
          result="$(printf "%s \\" "$result")"
        fi
        ;;
      -*=*)
        quote_start=''
        result="$(printf "%s\n%s%s \\" "$result" "$spaces" "$arg")"
        ;;
      -*)
        quote_start=''
        result="$(printf "%s\n%s%s " "$result" "$spaces" "$arg")"
        ;;
      *)
        first_char="$(get_first_char "$arg")"
        last_char="$(get_last_char "$arg")"

        if [ "$quote_start" = '' ] && { [ "$first_char" = '"' ] || [ "$first_char" = "'" ]; } && [ "$first_char" != "$last_char" ]; then
          quote_start="$first_char"
        elif [ "$quote_start" != '' ] && { [ "$last_char" = '"' ] || [ "$last_char" = "'" ]; } && [ "$first_char" != "$last_char" ]; then
          quote_start=''
        fi

        result="$(printf "%s%s" "$result" "$arg")"
        if [ "$count" -ne "$total" ]; then
          if [ "$quote_start" != '' ]; then
            result="$(printf "%s " "$result")"
          else
            result="$(printf "%s \\" "$result")"
          fi
        fi
        ;;
    esac
  done

  echo "$result"
}
