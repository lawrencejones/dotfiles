#FILE LOCATION ~/.profile

#------- Editing of .profile file and refresh command -----------
alias profile='vim ~/.profile && source ~/.profile'
alias aliases='vim ~/.bash_aliases && source ~/.bash_aliases'
alias dotfiles='cd ~/dotfiles'
#----------------------------------------------------------------

#------- Vim Commands -------------------------------------------
alias :q='exit'

#------- Git Aliases --------------------------------------------
alias git-init='git init && echo ".DS_Store" > .gitignore'
alias gs='git status'
alias ga='git add -A'
alias gc='git commit -a'
alias gac='git add -A :/ && git commit -a'
alias gcb='git checkout -b'
alias gd='git diff'
alias gb='git branch'
alias gp='git push'
#----------------------------------------------------------------

#------- Utilities ----------------------------------------------
alias ll='ls -lh'
alias clr='echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n " && clear'
alias listpath='echo $PATH | tr ":" "\n"'
alias sub='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl .'
alias tmux='tmux -2' # colors!!!
alias post-json='curl -X POST -H "Content-Type: application/json"'
alias twoup='lpr -o number-up=2 -o page-border=single'
alias mocha='mocha --compilers coffee:coffee-script/register'
alias indent-pb="pbpaste | sed 's/^/    /g' | pbcopy"
alias app-root='cd $(get-app-root)'
#----------------------------------------------------------------

#------  Work folder access -------------------------------------
alias projects='cd /Users/lawrencejones/Desktop/Projects'
alias sesquis='cd /Users/lawrencejones/Desktop/Projects/sesquis'
alias journal='cd /Users/lawrencejones/Desktop/Projects/journal'
#----------------------------------------------------------------

#------- PostgreSQL ---------------------------------------------
alias pg-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
#----------------------------------------------------------------

#------- Imperial Aliases ---------------------------------------
alias cate-token="git log | head -1 | awk -F' ' '{ print \$NF }' > ~/cate_token.txt"
#----------------------------------------------------------------

