# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='vim'
fi

HOSTNAME="$(hostname)"  # Conda clobbers HOST, so we save the real hostname into another variable.

precmd() {
    OLDHOST="${HOST}"
    HOST="${HOSTNAME}"
}

preexec() {
    HOST="${OLDHOST}"
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTTIMEFORMAT="%H:%M > "

export PATH=$PATH:$HOME/bin
export PATH="/usr/lib/ccache:$PATH"

unsetopt AUTO_CD

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
COLS=`tput cols`
alias center="sed  -e :a -e 's/^.\{1,'"$(( $COLS - 2 ))"'\}$/ & /;ta'"
alias ..="cd .."
alias div="tput sgr 0; tput bold; tput setaf 4; printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =; tput sgr 0"
alias smalldiv="tput bold; tput setaf 4; echo '********************' | center; tput sgr 0"
# Looks best on a terminal with black background.....
#echo -e "\[\e[0;31m\]This is BASH ${BASH_VERSION%.*}"
div
echo
echo
tput setaf 5
figlet -c -w `tput cols` -f broadway $HOSTNAME
tput sgr 0
echo
echo
tput sitm
tput setaf 6
echo welcome, "$USER" | center
tput sgr 0
echo
date | center
echo
uname -o | center
uname -r | center
uname -m | center
echo
smalldiv
echo
cat /proc/cpuinfo | grep -m 1 "model name" | awk -F":" '{print $2}' | center
free -m | grep Mem | awk '{print $3 "M of "$2"M RAM used ("$7"M cached)"}' | center
echo
smalldiv
echo
#df -h | grep "home\|md2\|sdh1" | awk '{print $3 " of "$2 " ("$5") on "$6}' | center
df -h | grep "data\|home\|\s\/$" | awk '{print $3 " of "$2 " ("$5") on "$6}' | center
echo
smalldiv
tput sitm
echo
echo "`python -m this`" | center
echo
div
tput sgr 0

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/camille/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/camille/miniconda/etc/profile.d/conda.sh" ]; then
        . "/home/camille/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/home/camille/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
