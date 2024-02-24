#!/usr/bin/env bats

export DISABLE_COLORS=1
export FUNCTIONS_DIRNAME="$BATS_TEST_DIRNAME"

load print_functions.sh

# print_binary_value() tests
@test "print_binary_value() should print the passed valid binary value with its name" {
  result="$(print_binary_value '0')"
  [ "$result" == '0 (disabled)' ]
  result="$(print_binary_value '1')"
  [ "$result" == '1 (enabled)' ]
}

@test "print_binary_value() should print \"<value> (invalid)\" when an invalid binary value is passed" {
  result="$(print_binary_value 'test')"
  [ "$result" == 'test (invalid)' ]
}

@test "print_binary_value() should print \"- (invalid)\" when an empty string is passed" {
  result="$(print_binary_value '')"
  [ "$result" == '- (invalid)' ]
}

@test "print_binary_value() should print \"- (empty)\" when an optional empty string is passed" {
  result="$(print_binary_value '' 1)"
  [ "$result" == '- (empty)' ]
}

# print_matched_value() tests
@test "print_matched_value() should print the matched value from the passed list" {
  languages='en-US
de-DE
it-IT
fr-FR
es-ES
ru-RU
zh-Hans
pt-BR
pl-PL'
  result="$(print_matched_value 'en-US' "$languages")"
  [ "$result" == 'en-US' ]
  result="$(print_matched_value 'es-ES' "$languages")"
  [ "$result" == 'es-ES' ]
  result="$(print_matched_value 'pl-PL' "$languages")"
  [ "$result" == 'pl-PL' ]
}

@test "print_matched_value() should print \"<value> (invalid)\" when an invalid unmatched value is passed" {
  languages='en-US
de-DE
it-IT
fr-FR
es-ES
ru-RU
zh-Hans
pt-BR
pl-PL'
  result="$(print_matched_value 'test' "$languages")"
  [ "$result" == 'test (invalid)' ]
}

@test "print_matched_value() should print \"- (invalid)\" when an empty string is passed" {
  result="$(print_matched_value '')"
  [ "$result" == '- (invalid)' ]
}

@test "print_matched_value() should print \"- (empty)\" when an optional empty string is passed" {
  result="$(print_matched_value '' '' 1)"
  [ "$result" == '- (empty)' ]
}

# print_string_value() tests
@test "print_string_value() should print the passed non-empty string" {
  result="$(print_string_value 'test')"
  [ "$result" == 'test' ]
}

@test "print_string_value() should print \"- (invalid)\" when an empty string is passed" {
  result="$(print_string_value '')"
  [ "$result" == '- (invalid)' ]
}

@test "print_string_value() should print \"- (empty)\" when an optional empty string is passed" {
  result="$(print_string_value '' 1)"
  [ "$result" == '- (empty)' ]
}

# print_autocreate_value() tests
@test "print_autocreate_value() should print the passed valid autocreate value with its name" {
  result="$(print_autocreate_value '1')"
  [ "$result" == '1 (small)' ]
  result="$(print_autocreate_value '2')"
  [ "$result" == '2 (medium)' ]
  result="$(print_autocreate_value '3')"
  [ "$result" == '3 (large)' ]
}

@test "print_autocreate_value() should print \"<value> (invalid)\" when an invalid autocreate value is passed" {
  result="$(print_autocreate_value 'test')"
  [ "$result" == 'test (invalid)' ]
}

@test "print_autocreate_value() should print \"- (invalid)\" when an empty string is passed" {
  result="$(print_autocreate_value '')"
  [ "$result" == '- (invalid)' ]
}

# print_difficulty_value() tests
@test "print_difficulty_value() should print the passed valid difficulty value with its name" {
  result="$(print_difficulty_value '0')"
  [ "$result" == '0 (normal)' ]
  result="$(print_difficulty_value '1')"
  [ "$result" == '1 (expert)' ]
  result="$(print_difficulty_value '2')"
  [ "$result" == '2 (master)' ]
  result="$(print_difficulty_value '3')"
  [ "$result" == '3 (journey)' ]
}

@test "print_difficulty_value() should print \"<value> (invalid)\" when an invalid difficulty value is passed" {
  result="$(print_difficulty_value 'test')"
  [ "$result" == 'test (invalid)' ]
}

@test "print_difficulty_value() should print \"- (invalid)\" when an empty string is passed" {
  result="$(print_difficulty_value '')"
  [ "$result" == '- (invalid)' ]
}

# print_maxplayers_value() tests
@test "print_maxplayers_value() should print the passed valid maxplayers value" {
  result="$(print_maxplayers_value '1')"
  [ "$result" == '1' ]
  result="$(print_maxplayers_value '128')"
  [ "$result" == '128' ]
  result="$(print_maxplayers_value '255')"
  [ "$result" == '255' ]
}

@test "print_maxplayers_value() should print \"<value> (invalid)\" when an invalid maxplayers value is passed" {
  result="$(print_maxplayers_value '0')"
  [ "$result" == '0 (invalid)' ]
  result="$(print_maxplayers_value '256')"
  [ "$result" == '256 (invalid)' ]
  result="$(print_maxplayers_value '999999')"
  [ "$result" == '999999 (invalid)' ]
  result="$(print_maxplayers_value 'test')"
  [ "$result" == 'test (invalid)' ]
}

@test "print_maxplayers_value() should print \"- (invalid)\" when an empty string is passed" {
  result="$(print_maxplayers_value '')"
  [ "$result" == '- (invalid)' ]
}

# print_npcstream_value() tests
@test "print_npcstream_value() should print the passed valid npcstream value" {
  result="$(print_npcstream_value '0')"
  [ "$result" == '0' ]
  result="$(print_npcstream_value '1')"
  [ "$result" == '1' ]
  result="$(print_npcstream_value '999999')"
  [ "$result" == '999999' ]
}

@test "print_npcstream_value() should print \"<value> (invalid)\" when an invalid npcstream value is passed" {
  result="$(print_npcstream_value '-1')"
  [ "$result" == '-1 (invalid)' ]
  result="$(print_npcstream_value 'test')"
  [ "$result" == 'test (invalid)' ]
}

@test "print_npcstream_value() should print \"- (invalid)\" when an empty string is passed" {
  result="$(print_npcstream_value '')"
  [ "$result" == '- (invalid)' ]
}

# print_port_value() tests
@test "print_port_value() should print the passed valid port value" {
  result="$(print_port_value '1')"
  [ "$result" == '1' ]
  result="$(print_port_value '7777')"
  [ "$result" == '7777' ]
  result="$(print_port_value '8080')"
  [ "$result" == '8080' ]
  result="$(print_port_value '65535')"
  [ "$result" == '65535' ]
}

@test "print_port_value() should print \"<value> (invalid)\" when an invalid port value is passed" {
  result="$(print_port_value '-1')"
  [ "$result" == '-1 (invalid)' ]
  result="$(print_port_value '0')"
  [ "$result" == '0 (invalid)' ]
  result="$(print_port_value '65536')"
  [ "$result" == '65536 (invalid)' ]
  result="$(print_port_value 'test')"
  [ "$result" == 'test (invalid)' ]
}

@test "print_port_value() should print \"- (invalid)\" when an empty string is passed" {
  result="$(print_port_value '')"
  [ "$result" == '- (invalid)' ]
}

# print_priority_value() tests
@test "print_priority_value() should print the passed valid priority value with its name" {
  result="$(print_priority_value '0')"
  [ "$result" == '0 (realtime)' ]
  result="$(print_priority_value '1')"
  [ "$result" == '1 (high)' ]
  result="$(print_priority_value '2')"
  [ "$result" == '2 (above normal)' ]
  result="$(print_priority_value '3')"
  [ "$result" == '3 (normal)' ]
  result="$(print_priority_value '4')"
  [ "$result" == '4 (below normal)' ]
  result="$(print_priority_value '5')"
  [ "$result" == '5 (idle)' ]
}

@test "print_priority_value() should print \"<value> (invalid)\" when an invalid priority value is passed" {
  result="$(print_priority_value 'test')"
  [ "$result" == 'test (invalid)' ]
}

@test "print_priority_value() should print \"- (invalid)\" when an empty string is passed" {
  result="$(print_priority_value '')"
  [ "$result" == '- (invalid)' ]
}

# print_journeypermission_value() tests
@test "print_journeypermission_value() should print the passed valid journey permission value with its name" {
  result="$(print_journeypermission_value '0')"
  [ "$result" == '0 (locked for everyone)' ]
  result="$(print_journeypermission_value '1')"
  [ "$result" == '1 (can only be changed by host)' ]
  result="$(print_journeypermission_value '2')"
  [ "$result" == '2 (can be changed by everyone)' ]
}

@test "print_journeypermission_value() should print \"<value> (invalid)\" when an invalid journey permission value is passed" {
  result="$(print_journeypermission_value 'test')"
  [ "$result" == 'test (invalid)' ]
}

@test "print_journeypermission_value() should print \"- (invalid)\" when an empty string is passed" {
  result="$(print_journeypermission_value '')"
  [ "$result" == '- (invalid)' ]
}

# print_announcementboxrange_value() tests
@test "print_announcementboxrange_value() should print the passed valid announcement box range value" {
  result="$(print_announcementboxrange_value '-1')"
  [ "$result" == '-1' ]
  result="$(print_announcementboxrange_value '1920')"
  [ "$result" == '1920' ]
  result="$(print_announcementboxrange_value '999999')"
  [ "$result" == '999999' ]
}

@test "print_announcementboxrange_value() should print \"<value> (invalid)\" when an invalid announcement box range value is passed" {
  result="$(print_announcementboxrange_value '-2')"
  [ "$result" == '-2 (invalid)' ]
  result="$(print_announcementboxrange_value 'test')"
  [ "$result" == 'test (invalid)' ]
}

@test "print_announcementboxrange_value() should print \"- (empty)\" when an empty string is passed" {
  result="$(print_announcementboxrange_value '')"
  [ "$result" == '- (empty)' ]
}

# print_ip_value() tests
@test "print_ip_value() should print the passed valid IP value" {
  result="$(print_ip_value '127.0.0.1')"
  [ "$result" == '127.0.0.1' ]
  result="$(print_ip_value '0.0.0.0')"
  [ "$result" == '0.0.0.0' ]
  result="$(print_ip_value '192.168.0.1')"
  [ "$result" == '192.168.0.1' ]
  result="$(print_ip_value '255.255.255.255')"
  [ "$result" == '255.255.255.255' ]
}

@test "print_ip_value() should print \"<value> (invalid)\" when an invalid IP value is passed" {
  result="$(print_ip_value '127.0.0')"
  [ "$result" == '127.0.0 (invalid)' ]
  result="$(print_ip_value 'test')"
  [ "$result" == 'test (invalid)' ]
}

@test "print_ip_value() should print \"- (empty)\" when an empty string is passed" {
  result="$(print_ip_value '')"
  [ "$result" == '- (empty)' ]
}

# print_lobby_value() tests
@test "print_lobby_value() should print the passed valid lobby value" {
  result="$(print_lobby_value 'friends')"
  [ "$result" == 'friends' ]
  result="$(print_lobby_value 'private')"
  [ "$result" == 'private' ]
}

@test "print_lobby_value() should print \"<value> (invalid)\" when an invalid lobby value is passed" {
  result="$(print_lobby_value 'test')"
  [ "$result" == 'test (invalid)' ]
}

@test "print_lobby_value() should print \"- (empty)\" when an empty string is passed" {
  result="$(print_lobby_value '')"
  [ "$result" == '- (empty)' ]
}
