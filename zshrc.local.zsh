# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


HOSTNAME="$(hostname)"  # Conda clobbers HOST, so we save the real hostname into another variable.

precmd() {
    OLDHOST="${HOST}"
    HOST="${HOSTNAME}"
}

preexec() {
    HOST="${OLDHOST}"
}

export EDITOR='vim'
export VIRTUAL_ENV_DISABLE_PROMPT=1
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTTIMEFORMAT="%H:%M > "
export PATH="/usr/lib/ccache:$PATH"

unsetopt AUTO_CD


alias ..="cd .."

#
# Pretty MOTD
#

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
smalldiv
echo
motd_dfinfo
echo
#smalldiv
#tput sitm
#echo
#acenterf "`python -m this`"
#echo
div
tput sgr 0
echo

#
# End MOTD
#

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
