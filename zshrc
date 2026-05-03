export PATH=$HOME/.local/bin:/usr/local/bin:/opt/hpccf/bin:$PATH
export EDITOR='nvim'
export VIRTUAL_ENV_DISABLE_PROMPT=1
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTTIMEFORMAT="%H:%M > "
export FZF_DEFAULT_COMMAND="rg --files"
export SQUEUE_FORMAT2='JobID:10,UserName:16 ,Partition:15,Name:20 ,State:12,Reason:12 ,SubmitTime,TimeLeft:15,NumCPUs:7,MinMemory:12,NumNodes:7,tres-per-node:15,NodeList'
export SQUEUE_SORT=V
#export SINFO_FORMAT='%17n %9P %.10T %.5c %.8z %.8m %20G %28E'
export SINFO_SORT=+N,+P
export EDITOR=nvim

alias ..="cd .."
alias vim="nvim"

unsetopt AUTO_CD
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
setopt interactivecomments
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent quiet yes
zstyle ':omz:alpha:lib:git' async-prompt no
zstyle ':znap:*' auto-compile no
ZSH_DISABLE_COMPFIX=true
export ZSH_HOME=$HOME/.local/share/zsh
export ZNAP_HOME=$ZSH_HOME/zsh-snap

if [[ ! -r $ZSH_HOME/setup-done ]]
then
    source $HOME/dotfiles/setup.zsh
fi

source $ZNAP_HOME/znap.zsh

znap source ohmyzsh/ohmyzsh lib/{git,async_prompt,prompt_info_functions,theme-and-appearance,history}
znap source ohmyzsh/ohmyzsh plugins/{catimg,colored-man-pages,colorize,conda-env,extract,git,git-extras,gitfast,pip,ssh-agent,fzf}
znap source tonyseek/oh-my-zsh-virtualenv-prompt
znap source lukechilds/zsh-nvm
znap source zsh-users/zsh-syntax-highlighting

#znap prompt dotfiles camillescott
source $ZSH_HOME/dotfiles/camillescott.zsh-theme

export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim', 'nvim')

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/dotfiles/site.zsh
# vim: set filetype=zsh: 
