ln -fs ~[dotfiles]/vimrc $HOME/.vimrc
ln -fs ~[dotfiles]/condarc $HOME/.condarc


centerf() {
  if [[ -n "$2" ]]
  then
    padding="$(printf '%0.1s' "$2"{1..500})"
  else
    padding="$(printf '%0.1s' ' '{1..500})"
  fi

  termwidth="$(tput cols)"

  printf '%*.*s %s %*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
}

acenterf() {
    local IFS=$'\n'
    for line ($=1) centerf "$line" $2
}

motd_welcome() {
    centerf "welcome, $USER"
}

motd_unames() {
    centerf "`uname -o`"
    centerf "`uname -r`"
    centerf "`uname -m`"
}

motd_cpuinfo() {
    centerf "`cat /proc/cpuinfo | grep -m 1 "model name" | awk -F":" '{print $2}'`"
}

motd_meminfo() {
    centerf "`free -m | grep Mem | awk '{print $3 "M of "$2"M RAM used ("$7"M cached)"}'`"
}

motd_dfinfo() {
    acenterf "`df -h | grep "data\|home\|\s\/$" | awk '{print $3 " of "$2 " ("$5") on "$6}'`"
}

export COLS=`tput cols`
alias div="tput sgr 0; tput bold; tput setaf 4; printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =; tput sgr 0"
alias smalldiv="tput bold; tput setaf 4; centerf '********************'; tput sgr 0"

source ~[dotfiles]/zshrc.local.zsh
