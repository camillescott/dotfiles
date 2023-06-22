export PATH=$HOME/.local/bin:/usr/local/bin:/opt/hpccf/bin:$PATH
zstyle :omz:plugins:ssh-agent agent-forwarding on
export ZSH_DISABLE_COMPFIX=true

source $HOME/.local/share/zsh/zsh-snap/znap.zsh
source ~[dotfiles]/site.zsh

znap source ohmyzsh/ohmyzsh lib/{git,prompt_info_functions,theme-and-appearance,history}
znap source tonyseek/oh-my-zsh-virtualenv-prompt

ZSH_THEME_CONDA_ENV_PROMPT_PREFIX="‹"
ZSH_THEME_CONDA_ENV_PROMPT_SUFFIX="› "
ZSH_THEME_PY_PROMPT_PREFIX="⟮py"
ZSH_THEME_PY_PROMPT_SUFFIX="⟯ "

export EDITOR='nvim'
export VIRTUAL_ENV_DISABLE_PROMPT=1
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTTIMEFORMAT="%H:%M > "

# automatically cd'ing into directories is annoying
unsetopt AUTO_CD

# save more history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

alias ..="cd .."
alias vim="nvim"
alias sudo="sudo -E"
export EDITOR=nvim

HOSTNAME="$(hostname)"  # Conda clobbers HOST, so we save the real hostname into another variable.
precmd() {
    OLDHOST="${HOST}"
    HOST="${HOSTNAME}"
}

preexec() {
    HOST="${OLDHOST}"
}

centerf() {
  if [[ -n "$2" ]]
  then
    pad="$2"
  else
    pad=" "
  fi

  var=" ${1} "
  print -r - ${(l[COLUMNS/2][ ]r[COLUMNS-COLUMNS/2][ ])var}
}

acenterf() {
    local IFS=$'\n'
    for line ($=1) centerf "$line" $2
}

motd_welcome() {
    centerf "$USER @ $HOSTNAME"
}

motd_unames() {
    if [[ `uname -s` == 'Darwin' ]]; then
        centerf "`uname -srm`"
    else
        centerf "`uname -o`"
        centerf "`uname -r`"
        centerf "`uname -m`"
    fi
}

motd_cpuinfo() {
    if [[ `uname -s` == 'Darwin' ]]; then
        centerf "`hostinfo | grep physically`"
        centerf "`hostinfo | grep logically`"
    else
        centerf "`cat /proc/cpuinfo | grep -m 1 "model name" | awk -F":" '{print $2}'`"
    fi
}

motd_meminfo() {
    if [[ `uname -s` == 'Darwin' ]]; then 
        centerf "`hostinfo | grep memory`"
    else
        centerf "`free -m | grep Mem | awk '{print $3 "M of "$2"M RAM used ("$7"M cached)"}'`"
    fi
}

motd_dfinfo() {
    if [[ `uname -s` == 'Darwin' ]]; then 
        acenterf "`df -h | grep /dev/disk1s1 | awk '{print $3,"of",$2,"("$5") used on "$9}'`"
    else
        acenterf "`df -h | grep "data\|home\|\s\/$" | awk '{print $3 " of "$2 " ("$5") on "$6}'`"
    fi
}

div() {
    tput sgr 0; tput bold; tput setaf 4; printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =; tput sgr 0
}

smalldiv() {
    tput bold; tput setaf 4; centerf '********************'; tput sgr 0
}

short_motd() {
    div
    tput setaf 5
    tput sgr 0
    echo
    tput sitm
    tput setaf 6
    motd_welcome
    tput sgr 0
    echo
    centerf "`date`"
    echo
    motd_unames
    echo
    smalldiv
    echo
    motd_cpuinfo
    motd_meminfo
    echo
    div
    tput sgr 0
    echo
}

short_motd
znap prompt dotfiles camillescott

export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim', 'nvim')
znap source lukechilds/zsh-nvm

znap source ohmyzsh/ohmyzsh plugins/git
znap source ohmyzsh/ohmyzsh plugins/colored-man-pages
znap source ohmyzsh/ohmyzsh plugins/colorize
znap source ohmyzsh/ohmyzsh plugins/catimg
znap source ohmyzsh/ohmyzsh plugins/extract
znap source ohmyzsh/ohmyzsh plugins/git-extras
znap source ohmyzsh/ohmyzsh plugins/pip
znap source ohmyzsh/ohmyzsh plugins/ssh-agent
znap source ohmyzsh/ohmyzsh plugins/fzf

znap source zsh-users/zsh-syntax-highlighting
znap source unixorn/fzf-zsh-plugin

echo

# vim: set filetype=zsh: 
