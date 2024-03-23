#!/usr/bin/env bats

load general_functions.sh

# trim() tests
@test "trim() should remove leading and trailing spaces" {
  result="$(trim '   hello world!   ')"
  [ "$result" == 'hello world!' ]
}
