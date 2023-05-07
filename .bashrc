#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
# https://bashrcgenerator.com/
# PS1="\[$(tput bold)\]\[\033[38;5;69m\]\u@\h\[$(tput sgr0)\] \W]\\$ \[$(tput sgr0)\]"

# os usage aliases
alias mpv720='mpv --ytdl-format=best[height=720] $1'
alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -vp"
alias rm='rm -rv'
alias l='ls -lah'
alias ff='find . -name $1'
alias grepf='grep -rin $1 $2'
alias rl='readlink -f $1'

# change directories easily
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Get External IP / Internet Speed
alias check_ip="curl https://ipinfo.io/json" # or /ip for plain-text ip
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"

# git
alias gs='git status'
alias ga='git add'
alias ga.='git add .'
alias gc='git commit'
alias gb='git branch'

complete -cf sudo
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"
