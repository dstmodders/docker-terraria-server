#!/usr/bin/env bats

# is_debug() tests
@test "is_debug() should print 1 when DEBUG_ENTRYPOINT is 1" {
  export DEBUG_ENTRYPOINT=1
  load debug_functions.sh
  result="$(is_debug)"
  [ "$result" == '1' ]
}

@test "is_debug() should print 0 when DEBUG_ENTRYPOINT is 0" {
  export DEBUG_ENTRYPOINT=0
  load debug_functions.sh
  result="$(is_debug)"
  [ "$result" == '0' ]
}

# debug_echo() tests
@test "debug_echo() should echo() the passed values when debug is enabled" {
  export DEBUG_ENTRYPOINT=1
  load debug_functions.sh
  result="$(debug_echo 'Hello' 'World!')"
  [ "$result" == 'Hello World!' ]
}

@test "debug_echo() should echo() nothing when debug is disabled" {
  export DEBUG_ENTRYPOINT=0
  load debug_functions.sh
  result="$(debug_echo 'Hello' 'World!')"
  [ "$result" == '' ]
}

# debug_printf() tests
@test "debug_printf() should printf() the passed values when debug is enabled" {
  export DEBUG_ENTRYPOINT=1
  load debug_functions.sh
  result="$(debug_printf 'Hello %s' 'World!')"
  [ "$result" == 'Hello World!' ]
}

@test "debug_printf() should printf() nothing when debug is disabled" {
  export DEBUG_ENTRYPOINT=0
  load debug_functions.sh
  result="$(debug_printf 'Hello %s' 'World!')"
  [ "$result" == '' ]
}
