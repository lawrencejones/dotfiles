#!/bin/bash

# This beloved script is a much-hacked version of the example at https://raw.githubusercontent.com/gnachman/iTerm2/master/tests/imgcat.
# It uses Quick Look and iTerm nightlies to display arbitrary files inline in the terminal
#
# To use, source this file and:
#    run "preview file1 file2 ..." for inline previews
#    run "ppreview file1 file2 ..." for popout previews

# print_image filename inline base64contents
#   filename: Filename to convey to client
#   inline: 0 or 1
#   base64contents: Base64-encoded contents

function print_image() {
    printf '\033]1337;File='
    if [[ -n "$1" ]]; then
      printf 'name='`echo -n "$1" | base64`";"
    fi
    if $(base64 --version | grep GNU > /dev/null)
    then
      BASE64ARG=-d
    else
      BASE64ARG=-D
    fi
    echo -n "$3" | base64 $BASE64ARG | wc -c | awk '{printf "size=%d",$1}'
    printf ";inline=$2"
    printf ":"
    echo -n "$3"
    printf '\a\n'
}

function preview() {
  for file in "$@"
  do
    if [ -r "$file" ] ; then
      preview_dir="/tmp"
      thumbnail_size=600

      qlmanage -t -s $thumbnail_size -o "$preview_dir" "$file" 1>/dev/null 2>/dev/null

      thumbnail=$preview_dir/$(basename "$file").png

      echo $file
      print_image "$thumbnail" 1 "$(base64 < "$thumbnail")"
    else
      echo "preview: $file: No such file or directory"
    fi
  done
}

function ppreview() {
  for file in "$@"
  do
    if [ -r "$file" ] ; then
      qlmanage -p "$file" 1>/dev/null 2>/dev/null &
    else
      echo "preview: $file: No such file or directory"
    fi
  done
}
