#!/usr/bin/env bats

load general_functions.sh

# get_first_char() tests
@test "get_first_char() should get the first character from the string" {
  result="$(get_first_char 'hello world!')"
  [ "$result" == 'h' ]
}

# trim() tests
@test "trim() should remove leading and trailing spaces" {
  result="$(trim '   hello world!   ')"
  [ "$result" == 'hello world!' ]
}
