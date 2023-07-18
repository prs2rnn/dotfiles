# Path to your zsh config, put it there and .zshrc in ~/
export ZSH="$HOME/.config/zsh-config"

# theme
ZSH_THEME="robbyrussell"

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# solve issue with ssh config
zstyle ':completion:*:ssh:*' hosts

# disable aliases of omz
zstyle ':omz:directories' aliases no

###............ ALIASES ............###

alias rsyncp='rsync -avr -e "ssh -p 7722"'
alias conwgW='sudo wg-quick up /etc/wireguard/wars.conf && notify-send -i security-high "connection is secured" "Europe"'
alias diconwgW='sudo wg-quick down /etc/wireguard/wars.conf && notify-send -i security-low "connection is not secured"'

alias mach_list_systemctl="systemctl list-unit-files --state=enabled"
alias ls='ls --color=auto'
alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -vp"
alias rm='rm -rv'
alias l='ls -lah'
alias ff='find . -name $1'
alias grepf='grep -rin $1 $2'  # $1-lookfor; $2-dir
alias rl='readlink -f $1'
alias v='$EDITOR'  # EDITOR=nvim first
alias xo='xdg-open $1'
alias c='xclip -selection clipboard'
alias p='xclip -o'  # paste

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias gpge='gpg -e -a -r 0x1F8BE9167FF0F8AC $2'  # $1 is id, $2 is file
alias mpv720='noglob mpv --ytdl-format=best[height=720] $1'
alias mpv_audio='f(){ noglob yt-dlp -o - "$1" | mpv --no-video -;  unset -f f; }; f'
alias check_ip="curl https://ipinfo.io/json" # or /ip for plain-text ip
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias hdmi_on="xrandr --output HDMI-1 --auto && xrandr --output eDP-1 --off"
alias hdmi_off="xrandr --output HDMI-1 --off && xrandr --output eDP-1 --on"


alias response-test="curl -s -w 'Testing Website Response Time for: %{url_effective}\n\nLookup Time:\t\t%{time_namelookup}\n\
Connect Time:\t\t%{time_connect}\nPre-transfer Time:\t%{time_pretransfer}\nStart-transfer Time:\t%{time_starttransfer}\n\
Appcon Time:\t\t%{time_appconnect}\nRedirect Time:\t\t%{time_redirect}\n\nTotal Time:\t\t%{time_total}\n\nReferrer:\
\thttps://www.techrepublic.com/article/how-to-test-website-speeds-curl\n' -o /dev/null $1"

alias gs='git status'
alias ga='git add'
alias ga.='git add .'
alias gc='git commit'
alias gb='git branch'
alias gch='git checkout'
alias gpl="git pull"
alias gplom="git pull origin main"
alias gph="git push"
alias gphom="git push origin main"
alias gd="git diff"
alias gcl="git clone"
alias glog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold green)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold yellow)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias gre="git restore $1"  # when modified and not add
alias grs="git restore --staged $1"  # when modified and add



###............ EXPORTS ............###

export EDITOR=nvim
export PATH=$HOME/.local/bin:$PATH
export PATH=/usr/sbin:$PATH
export PATH=~/.npm-global/bin:$PATH
# export TERM=xterm-256color  # for kitty

###............ SOURCE ............###

source $ZSH/oh-my-zsh.sh

###............ PLUGINS ............###

# just put it in plugins directory
plugins=(poetry)
