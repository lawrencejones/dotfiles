#!/bin/sh

### PATH CONFIGURATION #########################################################
# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin 
PATH=/usr/local/sbin:$PATH
# Add pintos toolchain
PATH=$PATH:/usr/local/i386-elf-gcc/bin
PATH=$PATH:/usr/local/pintos-utils
# Add my scripts to the path
export PATH="$HOME/.scripts:$PATH"

### SOURCE PACKAGE MANAGERS (RVM, NPM) #########################################
# Load in the RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Add npm locations to path if node exists
if [ $(type node >/dev/null; echo $?) == "0" ]; then
  export NODE_PATH="/usr/local/lib/node_modules:/usr/local/lib/node:$NODE_PATH"
  export PATH="/usr/local/share/npm/bin:$PATH"
  export PATH="/usr/local/bin/npm:$PATH"
fi

### BASH AUTOCOMPLETION CONFIG #################################################
# Support bash autocompletion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

### CONFIGURE TERMINAL COLORS ##################################################
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

# Set the ls folder and file color support
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Save the rgb color escape codes for scripts
export BLUE="\x1b[34m"
export RED="\x1b[31m"
export GREEN="\x1b[32m"
export CLRCOL="\x1b[0m"

### CONFIGURE PROMPT ###########################################################
_dynpath()
{
  #   How many characters of the $PWD should be kept
  local pwdmaxlen=30
  #   Indicator that there has been directory truncation:
  local trunc_symbol="..."
  if [ ${#PWD} -gt $pwdmaxlen ]
  then
    local pwdoffset=$(( ${#PWD} - $pwdmaxlen ))
    newPWD=`echo ${trunc_symbol}${PWD:$pwdoffset:$pwdmaxlen} | sed 's/^\.\.\.\([^/]*\)/.../g'`
  else
    newPWD=${PWD}
  fi
  echo $newPWD
}
# Set to the debian colors
PS1='\[\033[01;32m\]\u@\h\'
PS1=$PS1'[\033[00m\]\[\033[01;34m\] $(_dynpath)'
PS1=$PS1'\[\033[01;31m\]$(__git_ps1) \[\033[01;37m\]\$\[\033[00m\] '


### CONFIGURE LS AND GREP ######################################################
# Enable grep and ls color output
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors &&
      eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

### FIX TERMINAL ENCODING ######################################################
# Fix terminal encoding
export LC_ALL="en_GB.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_GB.UTF-8"

### C COMPILER SETTINGS ########################################################
# Set C compiler settings for mac
if [ $(uname) == "Darwin" ]; then
  export CC='gcc-4.7'
  export MAC='-Qunused-arguments'
fi

### SOURCE ANY EXTERNAL SCRIPTS ################################################
# Source aliases
source ~/.bash_aliases

