#!/usr/bin/env sh

set -e

functions_dirname=$(dirname "$0")
if [ -n "$FUNCTIONS_DIRNAME" ]; then
  functions_dirname="$FUNCTIONS_DIRNAME"
fi

. "$functions_dirname/print_functions.sh"
. "$functions_dirname/validate_functions.sh"

args='-config /data/config.txt'
config='/data/config.txt'
journey_permissions='journeypermission_biomespread_setfrozen
journeypermission_godmode
journeypermission_increaseplacementrange
journeypermission_rain_setfrozen
journeypermission_rain_setstrength
journeypermission_setdifficulty
journeypermission_setspawnrate
journeypermission_time_setdawn
journeypermission_time_setdusk
journeypermission_time_setfrozen
journeypermission_time_setmidnight
journeypermission_time_setnoon
journeypermission_time_setspeed
journeypermission_wind_setfrozen
journeypermission_wind_setstrength'
languages='en-US
de-DE
it-IT
fr-FR
es-ES
ru-RU
zh-Hans
pt-BR
pl-PL'
start_server=0

# parameters with their default values
# https://terraria.fandom.com/wiki/Server#Server_config_file
autocreate="$TERRARIA_AUTOCREATE"
banlist="$TERRARIA_BANLIST"
difficulty="$TERRARIA_DIFFICULTY"
journeypermission_biomespread_setfrozen="$TERRARIA_JOURNEYPERMISSION_BIOMESPREAD_SETFROZEN"
journeypermission_godmode="$TERRARIA_JOURNEYPERMISSION_GODMODE"
journeypermission_increaseplacementrange="$TERRARIA_JOURNEYPERMISSION_INCREASEPLACEMENTRANGE"
journeypermission_rain_setfrozen="$TERRARIA_JOURNEYPERMISSION_RAIN_SETFROZEN"
journeypermission_rain_setstrength="$TERRARIA_JOURNEYPERMISSION_RAIN_SETSTRENGTH"
journeypermission_setdifficulty="$TERRARIA_JOURNEYPERMISSION_SETDIFFICULTY"
journeypermission_setspawnrate="$TERRARIA_JOURNEYPERMISSION_SETSPAWNRATE"
journeypermission_time_setdawn="$TERRARIA_JOURNEYPERMISSION_TIME_SETDAWN"
journeypermission_time_setdusk="$TERRARIA_JOURNEYPERMISSION_TIME_SETDUSK"
journeypermission_time_setfrozen="$TERRARIA_JOURNEYPERMISSION_TIME_SETFROZEN"
journeypermission_time_setmidnight="$TERRARIA_JOURNEYPERMISSION_TIME_SETMIDNIGHT"
journeypermission_time_setnoon="$TERRARIA_JOURNEYPERMISSION_TIME_SETNOON"
journeypermission_time_setspeed="$TERRARIA_JOURNEYPERMISSION_TIME_SETSPEED"
journeypermission_wind_setfrozen="$TERRARIA_JOURNEYPERMISSION_WIND_SETFROZEN"
journeypermission_wind_setstrength="$TERRARIA_JOURNEYPERMISSION_WIND_SETSTRENGTH"
language="$TERRARIA_LANGUAGE"
maxplayers="$TERRARIA_MAXPLAYERS"
motd="$TERRARIA_MOTD"
npcstream="$TERRARIA_NPCSTREAM"
password="$TERRARIA_PASSWORD"
port="$TERRARIA_PORT"
priority="$TERRARIA_PRIORITY"
secure="$TERRARIA_SECURE"
seed="$TERRARIA_SEED"
upnp="$TERRARIA_UPNP"
world="$TERRARIA_WORLD"
worldname="$TERRARIA_WORLDNAME"
worldpath="$TERRARIA_WORLDPATH"

announcementboxrange="$TERRARIA_ANNOUNCEMENTBOXRANGE"
disableannouncementbox="$TERRARIA_DISABLEANNOUNCEMENTBOX"
forcepriority="$TERRARIA_FORCEPRIORITY"
ip="$TERRARIA_IP"
lobby="$TERRARIA_LOBBY"
steam="$TERRARIA_STEAM"

validate_known_parameter() {
  case "$1" in
    # https://terraria.fandom.com/wiki/Server#Command_line_parameters
    -config|-port|-players|-maxplayers|-pass|-password|-motd|-world|-autocreate|-banlist|-worldname|-secure|-noupnp|-steam|-lobby|-ip|-forcepriority|-disableannouncementbox|-announcementboxrange|-seed)
      echo 1
      return
      ;;
  esac
  echo 0
}

validate_required_parameter() {
  if [ -z "$2" ] || [ "$(validate_known_parameter "$2")" -eq 1 ]; then
    printf "Please specify the %s. For example: \`%s\`\n" "$3" "$4"
    exit 1
  fi
}

print_invalid_parameter_error() {
  name="$1"
  value="$2"
  expected="$3"
  expected_value="$4"
  if [ -z "$value" ]; then
    value='empty'
  fi
  printf "Invalid %s value (%s). Expected %s: %s\n" "$name" "$value" "$expected" "$expected_value"
}

print_parameters() {
  print_bold '[GENERAL PARAMETERS]'
  printf '\n\n'
  printf 'autocreate   %s\n' "$(print_autocreate_value "$autocreate")"
  printf 'banlist      %s\n' "$(print_path_value "$banlist")"
  printf 'difficulty   %s\n' "$(print_difficulty_value "$difficulty")"
  printf 'language     %s\n' "$(print_matched_value "$language" "$languages")"
  printf 'maxplayers   %s\n' "$(print_maxplayers_value "$maxplayers")"
  printf 'motd         %s\n' "$(print_string_value "$motd" 1)"
  printf 'npcstream    %s\n' "$(print_npcstream_value "$npcstream")"
  printf 'password     %s\n' "$(print_string_value "$password" 1)"
  printf 'port         %s\n' "$(print_port_value "$port")"
  printf 'priority     %s\n' "$(print_priority_value "$priority")"
  printf 'secure       %s\n' "$(print_binary_value "$secure")"
  printf 'seed         %s\n' "$(print_string_value "$seed" 1)"
  printf 'upnp         %s\n' "$(print_binary_value "$upnp")"
  printf 'world        %s\n' "$(print_path_value "$world")"
  printf 'worldname    %s\n' "$(print_string_value "$worldname")"
  printf 'worldpath    %s\n' "$(print_path_value "$worldpath")"

  if [ "$difficulty" = '3' ]; then
  printf '\n'
  print_bold '[JOURNEY PARAMETERS]'
  printf '\n\n'
    for permission in $journey_permissions; do
      value="$(eval echo "\$$permission")"
      printf '%-43s%s\n' "$permission" "$(print_journeypermission_value "$value")"
    done
  fi

  printf '\n'
  print_bold '[COMMAND-LINE PARAMETERS]'
  printf '\n\n'
  printf 'announcementboxrange     %s\n' "$(print_announcementboxrange_value "$announcementboxrange")"
  printf 'disableannouncementbox   %s\n' "$(print_binary_value "$disableannouncementbox" 1)"
  printf 'forcepriority            %s\n' "$(print_priority_value "$forcepriority" 1)"
  printf 'ip                       %s\n' "$(print_ip_value "$ip")"
  printf 'lobby                    %s\n' "$(print_lobby_value "$lobby")"
  printf 'steam                    %s\n' "$(print_binary_value "$steam" 1)"
}

save_config() {
  is_invalid=0

  # validate general parameters
  if [ "$(validate_autocreate "$autocreate")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'autocreate' "$autocreate" 'number' '1, 2 or 3'
  fi

  if [ "$(validate_path "$banlist")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'banlist' "$banlist" 'path' '/data/banlist.txt'
  fi

  if [ "$(validate_difficulty "$difficulty")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'difficulty' "$difficulty" 'number' '0, 1, 2 or 3'
  fi

  if [ "$(validate_matched "$language" "$languages")" -eq 0 ]; then
    is_invalid=1
    expected="$(echo "$languages" | sed ':a;N;$!ba;s/\n/, /g')"
    print_invalid_parameter_error 'language' "$language" 'language code' "${expected%,}"
  fi

  if [ "$(validate_maxplayers "$maxplayers")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'maxplayers' "$maxplayers" 'number' 'between 1 and 255'
  fi

  if [ "$(validate_npcstream "$npcstream")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'npcstream' "$npcstream" 'number' '0 or higher'
  fi

  if [ "$(validate_port "$port")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'port' "$port" 'number' 'between 1 and 65535'
  fi

  if [ "$(validate_priority "$priority")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'priority' "$priority" 'number' '0, 1, 2, 3, 4 or 5'
  fi

  if [ "$(validate_binary "$secure")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'secure' "$secure" 'boolean as number' '0 or 1'
  fi

  if [ "$(validate_binary "$upnp")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'upnp' "$upnp" 'boolean as number' '0 or 1'
  fi

  if [ "$(validate_path "$world")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'world' "$world" 'path' '/data/worlds/World.wld'
  fi

  if [ "$(validate_non_empty_string "$worldname")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'worldname' "$worldname" 'non-empty string' 'World'
  fi

  if [ "$(validate_path "$worldpath")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'worldpath' "$worldpath" 'path' '/data/worlds/'
  fi

  # validate journey permissions parameters
  for permission in $journey_permissions; do
    value="$(eval echo "\$$permission")"
    if [ "$(validate_journeypermission "$value")" -eq 0 ]; then
      is_invalid=1
      print_invalid_parameter_error "$permission" "$value" 'number' '0, 1, or 2'
    fi
  done

  # validate command-line parameters
  if [ -n "$announcementboxrange" ] && [ "$(validate_announcementboxrange "$announcementboxrange")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'announcementboxrange' "$announcementboxrange" 'number' '-1 or higher'
  fi

  if [ -n "$disableannouncementbox" ] && [ "$(validate_binary "$disableannouncementbox")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'disableannouncementbox' "$disableannouncementbox" 'boolean as number' '0 or 1'
  fi

  if [ -n "$forcepriority" ] && [ "$(validate_priority "$forcepriority")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'forcepriority' "$forcepriority" 'number' '0, 1, 2, 3, 4 or 5'
  fi

  if [ -n "$ip" ] && [ "$(validate_ip "$ip")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'ip' "$ip" 'IP' '127.0.0.1'
  fi

  if [ -n "$lobby" ] && [ "$(validate_lobby "$lobby")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'lobby' "$lobby" 'lobby value' 'friends or private'
  fi

  if [ -n "$steam" ] && [ "$(validate_binary "$steam")" -eq 0 ]; then
    is_invalid=1
    print_invalid_parameter_error 'steam' "$steam" 'boolean as number' '0 or 1'
  fi

  if [ "$is_invalid" -eq 1 ]; then
    exit 1
  fi

  # add command-line parameters
  if [ -n "$announcementboxrange" ]; then
    args="$args -announcementboxrange $announcementboxrange"
  fi

  if [ "$disableannouncementbox" = '1' ]; then
    args="$args -disableannouncementbox $disableannouncementbox"
  fi

  if [ -n "$ip" ]; then
    args="$args -ip $ip"
  fi

  if [ "$steam" = '1' ]; then
    args="$args -steam"
  fi

  if [ -n "$lobby" ]; then
    args="$args -lobby $lobby"
  fi

  echo "autocreate=$autocreate
banlist=$banlist
difficulty=$difficulty" > "$config"

  if [ "$difficulty" = '3' ]; then
    echo "journeypermission_biomespread_setfrozen=$journeypermission_biomespread_setfrozen
journeypermission_godmode=$journeypermission_godmode
journeypermission_increaseplacementrange=$journeypermission_increaseplacementrange
journeypermission_rain_setfrozen=$journeypermission_rain_setfrozen
journeypermission_rain_setstrength=$journeypermission_rain_setstrength
journeypermission_setdifficulty=$journeypermission_setdifficulty
journeypermission_setspawnrate=$journeypermission_setspawnrate
journeypermission_time_setdawn=$journeypermission_time_setdawn
journeypermission_time_setdusk=$journeypermission_time_setdusk
journeypermission_time_setfrozen=$journeypermission_time_setfrozen
journeypermission_time_setmidnight=$journeypermission_time_setmidnight
journeypermission_time_setnoon=$journeypermission_time_setnoon
journeypermission_time_setspeed=$journeypermission_time_setspeed
journeypermission_wind_setfrozen=$journeypermission_wind_setfrozen
journeypermission_wind_setstrength=$journeypermission_wind_setstrength" >> "$config"
  fi

  echo "language=$language
maxplayers=$maxplayers
motd=$motd
npcstream=$npcstream
password=$password
port=$port
priority=$priority
secure=$secure
seed=$seed
upnp=$upnp
world=$world
worldname=$worldname
worldpath=$worldpath" >> "$config"
}

while [ $# -gt 0 ]; do
  key="$1"
  value="$2"
  case "$key" in
    # https://terraria.fandom.com/wiki/Server#Command_line_parameters
    -config)
      validate_required_parameter "$key" "$value" 'config file path' '-config /data/config.txt'
      start_server=1
      config="$value"
      shift 2
      ;;
    -port)
      validate_required_parameter "$key" "$value" 'port number' '-port 7777'
      start_server=1
      port="$value"
      shift 2
      ;;
    -players|-maxplayers)
      validate_required_parameter "$key" "$value" 'players number' '-players 8'
      start_server=1
      maxplayers="$value"
      shift 2
      ;;
    -pass|-password)
      validate_required_parameter "$key" "$value" 'password value' "-password 'p@55w0rd*'"
      start_server=1
      password="$value"
      shift 2
      ;;
    -motd)
      validate_required_parameter "$key" "$value" 'motd value' "-motd 'Please don’t cut the purple trees!'"
      start_server=1
      motd="$value"
      shift 2
      ;;
    -world)
      validate_required_parameter "$key" "$value" 'world file path' '-world /data/worlds/World.wld'
      start_server=1
      world="$value"
      shift 2
      ;;
    -autocreate)
      validate_required_parameter "$key" "$value" 'autocreate value' '-autocreate 3'
      start_server=1
      autocreate="$value"
      shift 2
      ;;
    -banlist)
      validate_required_parameter "$key" "$value" 'banlist file path' '-banlist /data/banlist.txt'
      start_server=1
      banlist="$value"
      shift 2
      ;;
    -worldname)
      validate_required_parameter "$key" "$value" 'worldname value' '-worldname World'
      start_server=1
      worldname="$value"
      shift 2
      ;;
    -secure)
      validate_required_parameter "$key" "$value" 'secure value' '-secure 1'
      start_server=1
      secure="$value"
      shift 2
      ;;
    -noupnp)
      start_server=1
      upnp=0
      shift 1
      ;;
    -steam)
      start_server=1
      steam=1
      shift 1
      ;;
    -lobby)
      validate_required_parameter "$key" "$value" 'lobby value' '-lobby friends'
      start_server=1
      lobby="$value"
      shift 2
      ;;
    -ip)
      validate_required_parameter "$key" "$value" 'IP value' '-ip 127.0.0.1'
      start_server=1
      ip="$value"
      shift 2
      ;;
    -forcepriority)
      validate_required_parameter "$key" "$value" 'forcepriority value' '-forcepriority 0'
      start_server=1
      forcepriority="$value"
      shift 2
      ;;
    -disableannouncementbox)
      start_server=1
      disableannouncementbox=1
      shift 1
      ;;
    -announcementboxrange)
      validate_required_parameter "$key" "$value" 'announcementboxrange value' '-announcementboxrange 1000'
      start_server=1
      announcementboxrange="$value"
      shift 2
      ;;
    -seed)
      validate_required_parameter "$key" "$value" 'seed value' '-seed AwesomeSeed'
      start_server=1
      seed="$value"
      shift 2
      ;;
    /opt/terraria/TerrariaServer.bin.x86_64) start_server=1; shift ;;
    ./TerrariaServer.bin.x86_64)
      if [ "$(pwd)" = '/opt/terraria' ]; then
        start_server=1
        shift
      else
        save_config
        exec "$@"
      fi
      ;;
    TerrariaServer.bin.x86_64) start_server=1; shift ;;
    '')
      start_server=1
      ;;
    *)
      save_config
      exec "$@"
      ;;
  esac
done

save_config

if [ "$start_server" -eq 1 ]; then
  echo "Terraria version: $TERRARIA_VERSION"
  echo "Working directory: $(pwd)/"
  echo "Configuration: $config"
  echo "Command: /opt/terraria/TerrariaServer.bin.x86_64 $args"

  if [ -t 0 ]; then
    echo "TTY mode: enabled"
  else
    echo "TTY mode: disabled"
  fi

  printf '\n'
  print_parameters
  echo '---'
  # shellcheck disable=SC2086
  exec /opt/terraria/TerrariaServer.bin.x86_64 $args
fi
