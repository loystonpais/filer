#!/usr/bin/bash

# This makes the script more verbose 
set -x

### Running tests for filer commands

# Check if filer.sh exists before performing tests
# if not then exit
if [ ! -f filer.sh ]; then
  echo "Error: filer.sh not found. Run tests while being in project root"
fi


# Get realpath of the filer.sh file
filer_path=$( realpath filer.sh )

current_path=$( realpath . )

# Create a function that acts like filer command
# for ease of use
filer() {
  "$filer_path" "$@"
}

# This function takes the test function name
# and runs them in an isolated way
run_test() {
  test_name="$1"

  # Makes sure the function name is passed
  if [ -z "$test_name" ]; then 
    echo "Error: test function name is not provided"
    return 1
  fi

  # Check if function is declared or not
  if ! declare -f "$test_name" > /dev/null; then
    echo "Error: test function '$test_name' is not defined"
    return 1
  fi

  # Make a tmp dir to perform tests
  tmp="$( mktemp -d )"
  
  # cd to the tmpdir and run the test
  cd "$tmp"

  output=$( "$test_name" )
  exitcode=$?  #  save function exit code


  cd "$current_path"

  echo "######################"
  echo "Ran test $test_name"

  if [ $exitcode -eq "0" ]; then
    echo "Success ✅"
  else
    echo "Failed ❌"
  fi

  echo "Output: $output"

  # Remove the tmp dir after the tests 
  # are done
  rm -r "$tmp"

  return $exitcode
}



# Tests / test functions
test_backup() {
  touch foo.txt
  filer backup foo.txt

  if [ -f foo.txt.bak ]; then
    return 0
  else
    return 1
  fi
}

test_restore() {
  touch foo.txt.bak

  filer restore foo.txt

  if [ -f foo.txtg ]; then
    return 0
  else
    return 1
  fi
}

# Runs tests one by one
run() {
  count=0

  run_test "test_backup" && count=$(( $count + 1 ))
  run_test "test_restore" && count=$(( $count + 1 ))

  echo "Total succedeed tests: $count"
}

run