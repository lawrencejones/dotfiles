#FILE LOCATION ~/.profile

#------- Editing of .profile file and refresh command -----------
alias profile='vim ~/.profile && source ~/.profile'
alias aliases='vim ~/.bash_aliases && source ~/.bash_aliases'
#----------------------------------------------------------------

#------- Utilities ----------------------------------------------
alias ll='ls -lh'
alias clr='clear; clear; clear; clear; clear; clear; clear; clear'
alias listpath='echo $PATH | tr ":" "\n"'
alias sub='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl .'
alias wifi='networksetup -setairportnetwork en0 Imperial-WPA'
alias git-init='git init && echo ".DS_Store" > .gitignore'
alias tmux='tmux -2' # colors!!!
alias post-json='curl -X POST -H "Content-Type: application/json"'
alias pintos='pintos -v'
alias pmkdsk='pintos-mkdisk filesys.dsk --filesys-size=2 && pintos-mkdisk swap.dsk --swap-size=2'
alias nousers='coffee ~/.scripts/pull-cate-users.coffee'
alias doc-mongo='mongo dbh75.mongolab.com:27757/heroku_app23829204 -u heroku_app23829204 -p q66630pmpsqbbpv2214ung11l5'
alias pushh='git push heroku'
alias twoup='lpr -o number-up=2 -o page-border=single'
#----------------------------------------------------------------

#------  Work folder access -------------------------------------
alias projects='cd /Users/lawrencejones/Desktop/Projects'
alias timeline='cd /Users/lawrencejones/Desktop/Projects/jQueryTimeline'
alias livehack='cd /Users/lawrencejones/Desktop/Projects/LiveHack'
alias dgrep='cd /Users/lawrencejones/Desktop/Projects/grep-doc'
alias arm='cd /Users/lawrencejones/Desktop/Projects/arm'
alias sesquis='cd /Users/lawrencejones/Desktop/Projects/sesquis'
alias newpc='cd /Users/lawrencejones/Desktop/Projects/newpc'
alias gpios='cd /Users/lawrencejones/Desktop/Projects/gpio'
alias gyro='cd /Users/lawrencejones/Desktop/Projects/Virtual-Gyroscope'
alias c-tools='cd /Users/lawrencejones/Desktop/Projects/c-tools'
alias wacc='cd /Users/lawrencejones/Desktop/Projects/wacc'
alias labs='cd /Users/lawrencejones/Desktop/Labs'
alias dirpintos='cd /Users/lawrencejones/Desktop/Projects/pintos'
alias cgcu='cd ~/Projects/cgcu-scores'
#----------------------------------------------------------------

#------- Java/Coffeescript aliases ------------------------------
alias cpJquery='cp ~/jQuery_1_9.js ./jQuery.min.js'
#----------------------------------------------------------------

#------- PostgreSQL ---------------------------------------------
alias pg-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
#----------------------------------------------------------------

#------- Music Daemon Controls ----------------------------------
alias connect='ssh pi@$pi'
alias mpc='mpc -h $pi'
alias ncm='ncmpcpp -h $pi'
#----------------------------------------------------------------

#------- Rails Aliases ------------------------------------------
alias app-root='cd $(~/.scripts/get-app-root)'
#----------------------------------------------------------------

alias gs='git status'
alias cate-token="git log | head -1 | awk -F' ' '{ print \$NF }' > ~/cate_token.txt"
