#!/bin/bash

# Given a wildcard, will load queue for vim editing
edit-all() {
  find -name "$1" -exec vim {} \;
}
