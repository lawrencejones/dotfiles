#!/bin/sh

### SOURCE AMAZON ENHANCEMENTS #################################################

# If SDETools is deployed
if [ -d /apollo/env/SDETools ];
then

  ENV_IMP="/apollo/env/envImprovement/var/bashrc"
  [ -s $ENV_IMP ] && source $ENV_IMP  # This loads nvm
  PATH=$PATH:/apollo/env/HardyTools/bin

  # Setup brazil runtime exec alias
  alias br='LD_LIBRARY_PATH=$(brazil-path run.lib) /apollo/env/SDETools/bin/brazil-runtime-exec'

fi

# If brazil is available
if [ -n "$(brazil-bootstrap 2>/dev/null)" ];
then

  # Alias jruby/rake commands for dev box
  alias jruby='$(brazil-bootstrap)/jruby1.7.x/dist/bin/jruby'
  alias jrake='$(brazil-bootstrap)/jruby1.7.x/dist/bin/rake'
  alias jirb='$(brazil-bootstrap)/jruby1.7.x/dist/bin/irb'
  alias jrails='$(brazil-bootstrap)/jruby1.7.x/dist/bin/jruby $(brazil-bootstrap)/jruby1.7.x/ruby/gems/shared/bin/rails'

fi

### PATH CONFIGURATION #########################################################
# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin
PATH=/usr/local/sbin:$PATH

# Add selecta to path for vim
PATH=$PATH:$HOME/.vim/bundle/selecta

### SELECT GNU COMMANDS ########################################################
# For those commands that require a g prefix, select if exist
cmds="ls grep find dircolors"
for cmd in $cmds
do
  $(which g$cmd >/dev/null 2>/dev/null) && alias $cmd="g$cmd"
done

# Enable spell checking for commands
shopt -s cdspell

### CONFIGURE TERMINAL COLORS ##################################################
# Set the ls folder and file color support
export CLICOLOR=1
export   CLRCOL=$'\e[0m'

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

### SOURCE PACKAGE MANAGERS (RVM, NPM) #########################################
# Load in the RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Add npm locations to path if node exists
if [ -n "$(node --version 2>/dev/null)" ]; then
  export NODE_PATH="/usr/local/lib/node_modules:/usr/local/lib/node:$NODE_PATH"
  export PATH="/usr/local/share/npm/bin:$PATH"
  export PATH="/usr/local/bin/npm:$PATH"
fi

### CONFIGURE LS AND GREP ######################################################
# If supported, then run dircolors
if [[ $(dircolors 2>/dev/null) ]];
then
  $(gls --color=always &>/dev/null) && alias ls='gls --color=always'
  test -r ~/.dircolors/dircolors.$theme &&
    eval "$(dircolors -b ~/.dircolors/dircolors.$theme &>/dev/null)" || eval "$(dircolors -b)"
else
  # Default ls and colors
  export LSCOLORS=GxFxCxDxBxegedabagaced
fi

# If we have gnu-grep
$(which ggrep &>/dev/null) && alias grep='ggrep --color=auto'

# Force color output in tree
alias tree='tree -C'

### SOURCE ANY EXTERNAL SCRIPTS ################################################

# Source variables
source ~/.bash_vars

# Source aliases
source ~/.bash_ps1
source ~/.bash_aliases

# Well duh
export EDITOR=vim

