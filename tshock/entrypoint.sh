#!/usr/bin/env sh

set -e

functions_dirname=$(dirname "$0")
if [ -n "$FUNCTIONS_DIRNAME" ]; then
  functions_dirname="$FUNCTIONS_DIRNAME"
fi

. "$functions_dirname/debug_functions.sh"
. "$functions_dirname/general_functions.sh"
. "$functions_dirname/print_functions.sh"
. "$functions_dirname/validate_functions.sh"

# paths
binary='/opt/tshock/TShock.Server'

# general
args=''
binary_basename="$(basename "$binary")"
start_server=0

# server parameters with their default values
# https://ikebukuro.tshock.co/#/command-line-parameters
additionalplugins="$TSHOCK_ADDITIONALPLUGINS"
configpath="$TSHOCK_CONFIGPATH"
crashdir="$TSHOCK_CRASHDIR"
logpath="$TSHOCK_LOGPATH"
worldselectpath="$TSHOCK_WORLDSELECTPATH"

add_arg() {
  key="$1"
  value="$2"
  arg=''

  if [ -n "$value" ]; then
    arg="$key $value"
  else
    arg="$key"
  fi

  if [ -n "$args" ]; then
    args="$args $arg"
  else
    args="$args$arg"
  fi
}

print_parameters() {
  print_bold '[COMMAND-LINE PARAMETERS]'
  printf '\n\n'
  printf 'additionalplugins   %s\n' "$(print_path_value "$additionalplugins")"
  printf 'configpath          %s\n' "$(print_path_value "$configpath")"
  printf 'crashdir            %s\n' "$(print_path_value "$crashdir")"
  printf 'logpath             %s\n' "$(print_path_value "$logpath")"
  printf 'worldselectpath     %s\n' "$(print_path_value "$worldselectpath")"
}

while [ $# -gt 0 ]; do
  key="$(trim "$1")"
  value="$(trim "$2")"
  case "$key" in
    # https://ikebukuro.tshock.co/#/command-line-parameters
    -ip|-port|-maxplayers|-players|-world|-worldname|-autocreate|-config|-pass|-password|-motd|-logformat|-worldevil|-difficulty|-loadlib)
      start_server=1
      add_arg "$key" "$value"
      shift 2
      ;;
    -ignoreversion|-forceupdate|-autoshutdown|-secure|-logclear|-dump|-heaptile|-constileation|-c)
      start_server=1
      add_arg "$key"
      shift 1
      ;;
    -worldselectpath)
      start_server=1
      worldselectpath="$value"
      shift 2
      ;;
    -configpath)
      start_server=1
      configpath="$value"
      shift 2
      ;;
    -logpath)
      start_server=1
      logpath="$value"
      shift 2
      ;;
    -crashdir)
      start_server=1
      crashdir="$value"
      shift 2
      ;;
    -additionalplugins)
      start_server=1
      additionalplugins="$value"
      shift 2
      ;;
    "./$binary_basename")
      if [ "$(pwd)" = '/opt/tshock' ]; then
        start_server=1
        shift
      else
        exec "$@"
      fi
      ;;
    "$binary") start_server=1; shift ;;
    "$binary_basename") start_server=1; shift ;;
    '') start_server=1 ;;
    *) exec "$@" ;;
  esac
done

add_arg '-additionalplugins' "$additionalplugins"
add_arg '-configpath' "$configpath"
add_arg '-crashdir' "$crashdir"
add_arg '-logpath' "$logpath"
add_arg '-worldselectpath' "$worldselectpath"

if [ "$start_server" -eq 1 ]; then
  if [ "$DISABLE_SUMMARY" != '1' ]; then
    echo "Terraria version: $TERRARIA_VERSION"
    echo "TShock version: $TERRARIA_TSHOCK_VERSION"
    echo "Working directory: $(pwd)/"
    echo "Command: $(print_command "$binary $args")"

    if [ -t 0 ]; then
      echo "TTY mode: enabled"
    else
      echo "TTY mode: disabled"
    fi

    printf '\n'
    print_parameters
    echo '---'
  fi

  mkdir -p "$configpath" "$crashdir" "$logpath" "$additionalplugins" "$worldselectpath"
  exec "$binary" $args
fi
