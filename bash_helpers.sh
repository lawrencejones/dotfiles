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
