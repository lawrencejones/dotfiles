#!/bin/sh
# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin 
PATH=$PATH:/usr/local/sbin
# Load in the RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Add npm locations to path if node exists
if [$(type node >/dev/null; echo $?) == "0"]; then
  export NODE_PATH="/usr/local/lib/node_modules:/usr/local/lib/node:$NODE_PATH"
  export PATH="/usr/local/share/npm/bin:$PATH"
  export PATH="/usr/local/bin/npm:$PATH"
fi

# Support bash autocompletion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Set terminal to color on
force_color_prompt=yes

# Double check color support#
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  color_prompt=yes
    else
  color_prompt=
    fi
fi

# Set to the debian colors
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\'
PS1=$PS1'[\033[00m\]\[\033[01;34m\]\w \$\[\033[00m\] '

# Set the ls folder and file color support
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Save the rgb color escape codes for scripts
export BLUE="\x1b[34m"
export RED="\x1b[31m"
export GREEN="\x1b[32m"
export CLRCOL="\x1b[0m"

# Enable grep and ls color output
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Fix terminal encoding
export LC_ALL="en_GB.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_GB.UTF-8"

# Set C compiler settings for mac
if [$(uname) == "Darwin"]; then
  export CC='gcc-4.7'
  export MAC='-Qunused-arguments'
fi

# Add my scripts to the path
export PATH="$HOME/.scripts:$PATH"

# Source aliases
source ~/.bash-aliases

