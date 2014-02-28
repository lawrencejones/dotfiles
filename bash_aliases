#FILE LOCATION ~/.profile

#------- Editing of .profile file and refresh command -----------
alias profile='vim ~/.profile && source ~/.profile'
alias aliases='vim ~/.aliases && source ~/.aliases'
#----------------------------------------------------------------

#------- Utilities ----------------------------------------------
alias ll='ls -lh'
alias clr='clear; clear; clear; clear; clear; clear; clear; clear'
alias listpath='echo $PATH | tr ":" "\n"'
alias sub='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl .'
alias wifi='networksetup -setairportnetwork en0 Imperial-WPA'
alias git-init='git init && echo ".DS_Store" > .gitignore'
alias find='gfind'
alias tmux='tmux -2' # colors!!!
alias post-json='curl -X POST -H "Content-Type: application/json"'
#----------------------------------------------------------------

#------  Work folder access -------------------------------------
alias projects='cd /Users/lawrencejones/Desktop/Projects'
alias timeline='cd /Users/lawrencejones/Desktop/Projects/jQueryTimeline'
alias livehack='cd /Users/lawrencejones/Desktop/Projects/LiveHack'
alias classy='cd /Users/lawrencejones/Desktop/Projects/classy-cate'
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
alias app-root='cd $(get-app-root)'
#----------------------------------------------------------------

alias cate-token="git log | head -1 | awk -F' ' '{ print \$NF }' > ~/cate_token.txt"
