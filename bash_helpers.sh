#!/bin/bash

# Given a wildcard, will load queue for vim editing
edit-all() {
  find -name "$1" -exec vim {} \;
}

# Search and replace with sed
sr() {
  find -name "$1" -exec sed -i "$2" {} \;
}

# Initiates new scratch folder
scratch() {
  SCRATCH_DIR="$HOME/scratch"
  mkdir -p "$SCRATCH_DIR/$1" && cd "$SCRATCH_DIR/$1"
}

# Extracts token from given line
# token <index> <delimiter?>
token() {

  index=$1; : ${index:="1"}
  delimiter=$2; : ${delimiter:=$'\t'}

  cut -d"$delimiter" -f"$index"

}

# Extracts given line from stdin.
# line <index> <count?>
line() {

  index=$1; : ${index:="1"}
  count=$2; : ${count:="1"}

  head -n `expr $index + $count - 1` | tail -$count

}
