#!/bin/sh

### PATH CONFIGURATION #########################################################
# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin
PATH=/usr/local/sbin:$PATH

### SOURCE PACKAGE MANAGERS (RVM, NPM) #########################################
# Load in the RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


# Add npm locations to path if node exists
if [ $(type node >/dev/null; echo $?) == "0" ]; then
  export NODE_PATH="/usr/local/lib/node_modules:/usr/local/lib/node:$NODE_PATH"
  export PATH="/usr/local/share/npm/bin:$PATH"
  export PATH="/usr/local/bin/npm:$PATH"
fi

### CONFIGURE TERMINAL COLORS ##################################################
# Set the theme name
export theme="molokai"  # keep theme choices up to date
source ~/.colors/colors.$theme

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

### CONFIGURE LS AND GREP ######################################################
# Set the ls folder and file color support
export CLICOLOR=1
export   CLRCOL=$'\e[0m'
# Verify we have dircolors
if [ -n "$(gdircolors --version 2>/dev/null)" ];
then
  [ -n "$(gls --version 2>/dev/null)" ] && alias ls='gls --color=always'
  test -r ~/.dircolors/dircolors.$theme &&
    eval "$(gdircolors -b ~/.dircolors/dircolors.$theme)" || eval "$(dircolors -b)"
else
  # Default ls and colors
  export LSCOLORS=GxFxCxDxBxegedabagaced
fi

# If we have gnu-grep
if [ -n "$(ggrep --version 2>/dev/null)" ];
then
  alias grep='ggrep --color=auto'
fi

alias ls='ls --color'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

### SOURCE ANY EXTERNAL SCRIPTS ################################################
# Source variables
source ~/.bash_vars
# Source aliases
source ~/.bash_ps1
source ~/.bash_aliases

# Well duh
export EDITOR=vim
