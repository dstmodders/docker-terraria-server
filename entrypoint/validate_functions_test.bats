#!/usr/bin/env bats

load validate_functions.sh

# validate_binary() tests
@test "validate_binary() should print 1 when a valid binary is passed" {
  result="$(validate_binary '0')"
  [ "$result" == '1' ]
  result="$(validate_binary '1')"
  [ "$result" == '1' ]
}

@test "validate_binary() should print 0 when an invalid binary is passed" {
  result="$(validate_binary '3')"
  [ "$result" == '0' ]
  result="$(validate_binary '')"
  [ "$result" == '0' ]
  result="$(validate_binary 'test')"
  [ "$result" == '0' ]
}

# validate_matched() tests
@test "validate_matched() should print 1 when a valid matched value is passed" {
  LANGUAGES='en-US
de-DE
it-IT
fr-FR
es-ES
ru-RU
zh-Hans
pt-BR
pl-PL'
  result="$(validate_matched 'en-US' "$LANGUAGES")"
  [ "$result" == '1' ]
  result="$(validate_matched 'es-ES' "$LANGUAGES")"
  [ "$result" == '1' ]
  result="$(validate_matched 'pl-PL' "$LANGUAGES")"
  [ "$result" == '1' ]
}

@test "validate_matched() should print 0 when an invalid matched value is passed" {
  LANGUAGES='en-US
de-DE
it-IT
fr-FR
es-ES
ru-RU
zh-Hans
pt-BR
pl-PL'
  result="$(validate_matched 'et-EE' "$LANGUAGES")"
  [ "$result" == '0' ]
  result="$(validate_matched '' "$LANGUAGES")"
  [ "$result" == '0' ]
  result="$(validate_matched 'test' "$LANGUAGES")"
  [ "$result" == '0' ]
}

# validate_non_empty_string() tests
@test "validate_non_empty_string() should print 1 when a non-empty string is passed" {
  result="$(validate_non_empty_string 'test')"
  [ "$result" == '1' ]
  result="$(validate_non_empty_string '1')"
  [ "$result" == '1' ]
  result="$(validate_non_empty_string 1)"
  [ "$result" == '1' ]
}

@test "validate_non_empty_string() should print 0 when an empty string is passed" {
  result="$(validate_non_empty_string '')"
  [ "$result" == '0' ]
}

# validate_path() tests
@test "validate_path() should print 1 when a valid path is passed" {
  result="$(validate_path '/')"
  [ "$result" == '1' ]
  result="$(validate_path '/tmp')"
  [ "$result" == '1' ]
  result="$(validate_path '/tmp/')"
  [ "$result" == '1' ]
  result="$(validate_path '/path/to/file')"
  [ "$result" == '1' ]
  result="$(validate_path '/path/to/file.txt')"
  [ "$result" == '1' ]
  result="$(validate_path '/path/to/dir')"
  [ "$result" == '1' ]
  result="$(validate_path '/path/to/dir/')"
  [ "$result" == '1' ]
  result="$(validate_path '/path/to/0')"
  [ "$result" == '1' ]
  result="$(validate_path '/path/to/FILE')"
  [ "$result" == '1' ]
  result="$(validate_path '/path/to/FILE.txt')"
  [ "$result" == '1' ]
  result="$(validate_path '/path/to/file-with-dashes')"
  [ "$result" == '1' ]
  result="$(validate_path '/path/to/file-with-dashes.txt')"
  [ "$result" == '1' ]
  result="$(validate_path '/path/to/file_with_underscores')"
  [ "$result" == '1' ]
  result="$(validate_path '/path/to/file_with_underscores.txt')"
  [ "$result" == '1' ]
  result="$(validate_path 'path/to/file')"
  [ "$result" == '1' ]
  result="$(validate_path 'path/to/file.txt')"
  [ "$result" == '1' ]
  result="$(validate_path '.')"
  [ "$result" == '1' ]
  result="$(validate_path './')"
  [ "$result" == '1' ]
  result="$(validate_path './path/to/file')"
  [ "$result" == '1' ]
  result="$(validate_path './path/to/file.txt')"
  [ "$result" == '1' ]
}

@test "validate_path() should print 0 when an invalid path is passed" {
  result="$(validate_path '')"
  [ "$result" == '0' ]
  result="$(validate_path '\tmp/test')"
  [ "$result" == '0' ]
  result="$(validate_path '\tmp/hello world')"
  [ "$result" == '0' ]
}

# validate_autocreate() tests
@test "validate_autocreate() should print 1 when a valid autocreate is passed" {
  result="$(validate_autocreate '1')"
  [ "$result" == '1' ]
  result="$(validate_autocreate '2')"
  [ "$result" == '1' ]
  result="$(validate_autocreate '3')"
  [ "$result" == '1' ]
}

@test "validate_autocreate() should print 0 when an invalid autocreate is passed" {
  result="$(validate_autocreate '4')"
  [ "$result" == '0' ]
  result="$(validate_autocreate '')"
  [ "$result" == '0' ]
  result="$(validate_autocreate 'test')"
  [ "$result" == '0' ]
}

# validate_difficulty() tests
@test "validate_difficulty() should print 1 when a valid difficulty is passed" {
  result="$(validate_difficulty '0')"
  [ "$result" == '1' ]
  result="$(validate_difficulty '1')"
  [ "$result" == '1' ]
  result="$(validate_difficulty '2')"
  [ "$result" == '1' ]
  result="$(validate_difficulty '3')"
  [ "$result" == '1' ]
}

@test "validate_difficulty() should print 0 when an invalid difficulty is passed" {
  result="$(validate_difficulty '4')"
  [ "$result" == '0' ]
  result="$(validate_difficulty '')"
  [ "$result" == '0' ]
  result="$(validate_difficulty 'test')"
  [ "$result" == '0' ]
}

# validate_maxplayers() tests
@test "validate_maxplayers() should print 1 when a valid maxplayers is passed" {
  result="$(validate_maxplayers '1')"
  [ "$result" == '1' ]
  result="$(validate_maxplayers '128')"
  [ "$result" == '1' ]
  result="$(validate_maxplayers '255')"
  [ "$result" == '1' ]
}

@test "validate_maxplayers() should print 0 when an invalid maxplayers is passed" {
  result="$(validate_maxplayers '256')"
  [ "$result" == '0' ]
  result="$(validate_maxplayers '999999')"
  [ "$result" == '0' ]
  result="$(validate_maxplayers '')"
  [ "$result" == '0' ]
  result="$(validate_maxplayers 'test')"
  [ "$result" == '0' ]
}

# validate_npcstream() tests
@test "validate_npcstream() should print 1 when a valid npcstream is passed" {
  result="$(validate_npcstream '0')"
  [ "$result" == '1' ]
  result="$(validate_npcstream '1')"
  [ "$result" == '1' ]
  result="$(validate_npcstream '999999')"
  [ "$result" == '1' ]
}

@test "validate_npcstream() should print 0 when an invalid npcstream is passed" {
  result="$(validate_npcstream '-1')"
  [ "$result" == '0' ]
  result="$(validate_npcstream '')"
  [ "$result" == '0' ]
  result="$(validate_npcstream 'test')"
  [ "$result" == '0' ]
}

# validate_port() tests
@test "validate_port() should print 1 when a valid port is passed" {
  result="$(validate_port '1')"
  [ "$result" == '1' ]
  result="$(validate_port '7777')"
  [ "$result" == '1' ]
  result="$(validate_port '8080')"
  [ "$result" == '1' ]
  result="$(validate_port '65535')"
  [ "$result" == '1' ]
}

@test "validate_port() should print 0 when an invalid port is passed" {
  result="$(validate_port '-1')"
  [ "$result" == '0' ]
  result="$(validate_port '0')"
  [ "$result" == '0' ]
  result="$(validate_port '65536')"
  [ "$result" == '0' ]
  result="$(validate_port '')"
  [ "$result" == '0' ]
  result="$(validate_port 'test')"
  [ "$result" == '0' ]
}

# validate_priority() tests
@test "validate_priority() should print 1 when a valid priority is passed" {
  result="$(validate_priority '0')"
  [ "$result" == '1' ]
  result="$(validate_priority '1')"
  [ "$result" == '1' ]
  result="$(validate_priority '2')"
  [ "$result" == '1' ]
  result="$(validate_priority '3')"
  [ "$result" == '1' ]
  result="$(validate_priority '4')"
  [ "$result" == '1' ]
  result="$(validate_priority '5')"
  [ "$result" == '1' ]
}

@test "validate_priority() should print 0 when an invalid priority is passed" {
  result="$(validate_priority '6')"
  [ "$result" == '0' ]
  result="$(validate_priority '')"
  [ "$result" == '0' ]
  result="$(validate_priority 'test')"
  [ "$result" == '0' ]
}

# validate_journeypermission() tests
@test "validate_journeypermission() should print 1 when a valid journey permission is passed" {
  result="$(validate_journeypermission '0')"
  [ "$result" == '1' ]
  result="$(validate_journeypermission '1')"
  [ "$result" == '1' ]
  result="$(validate_journeypermission '2')"
  [ "$result" == '1' ]
}

@test "validate_journeypermission() should print 0 when an invalid journey permission is passed" {
  result="$(validate_journeypermission '3')"
  [ "$result" == '0' ]
  result="$(validate_journeypermission '')"
  [ "$result" == '0' ]
  result="$(validate_journeypermission 'test')"
  [ "$result" == '0' ]
}

# validate_announcementboxrange() tests
@test "validate_announcementboxrange() should print 1 when a valid announcement box range is passed" {
  result="$(validate_announcementboxrange '-1')"
  [ "$result" == '1' ]
  result="$(validate_announcementboxrange '1920')"
  [ "$result" == '1' ]
  result="$(validate_announcementboxrange '999999')"
  [ "$result" == '1' ]
}

@test "validate_announcementboxrange() should print 0 when an invalid announcement box range is passed" {
  result="$(validate_announcementboxrange '-2')"
  [ "$result" == '0' ]
  result="$(validate_announcementboxrange '')"
  [ "$result" == '0' ]
  result="$(validate_announcementboxrange 'test')"
  [ "$result" == '0' ]
}

# validate_ip() tests
@test "validate_ip() should print 1 when a valid IP is passed" {
  result="$(validate_ip '127.0.0.1')"
  [ "$result" == '1' ]
  result="$(validate_ip '0.0.0.0')"
  [ "$result" == '1' ]
  result="$(validate_ip '192.168.0.1')"
  [ "$result" == '1' ]
  result="$(validate_ip '255.255.255.255')"
  [ "$result" == '1' ]
}

@test "validate_ip() should print 0 when an invalid IP is passed" {
  result="$(validate_ip '127.0.0')"
  [ "$result" == '0' ]
  result="$(validate_ip '')"
  [ "$result" == '0' ]
  result="$(validate_ip 'test')"
  [ "$result" == '0' ]
}

# validate_lobby() tests
@test "validate_lobby() should print 1 when a valid lobby is passed" {
  result="$(validate_lobby 'friends')"
  [ "$result" == '1' ]
  result="$(validate_lobby 'private')"
  [ "$result" == '1' ]
}

@test "validate_lobby() should print 0 when an invalid lobby is passed" {
  result="$(validate_lobby '')"
  [ "$result" == '0' ]
  result="$(validate_lobby 'test')"
  [ "$result" == '0' ]
}
