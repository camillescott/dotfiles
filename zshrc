export PATH=$HOME/.local/bin:/usr/local/bin:/opt/hpccf/bin:$PATH
setopt interactivecomments
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent quiet yes
zstyle ':omz:alpha:lib:git' async-prompt no
zstyle ':znap:*' auto-compile no
ZSH_DISABLE_COMPFIX=true
export ZSH_HOME=$HOME/.local/share/zsh
export ZNAP_HOME=$ZSH_HOME/zsh-snap

if [[ ! -r $ZNAP_HOME/znap.zsh ]]
then
    mkdir -p $ZNAP_HOME
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git $ZNAP_HOME
fi
source $ZNAP_HOME/znap.zsh
source $HOME/dotfiles/site.zsh

if [[ ! -h $ZSH_HOME/dotfiles ]]
then
    ln -fs $HOME/dotfiles $ZSH_HOME/dotfiles
fi

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

# automatically cd'ing into directories is annoying
unsetopt AUTO_CD

# save more history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

alias ..="cd .."
alias vim="nvim"
alias sudo="sudo -E"
export EDITOR=nvim

#HOSTNAME="$(hostname)"  # Conda clobbers HOST, so we save the real hostname into another variable.
#precmd() {
#    OLDHOST="${HOST}"
#    HOST="${HOSTNAME}"
#}

#preexec() {
#    HOST="${OLDHOST}"
#}

export NVIM_APPIMAGE='https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage'
function get_nvim() {
    mkdir -p $HOME/.local/bin
    curl -L $NVIM_APPIMAGE > $HOME/.local/bin/nvim.appimage
    chmod +x $HOME/.local/bin/nvim.appimage
    ln -s $HOME/.local/bin/nvim.appimage $HOME/.local/bin/nvim
}

znap source ohmyzsh/ohmyzsh lib/{git,async_prompt,prompt_info_functions,theme-and-appearance,history}
znap source tonyseek/oh-my-zsh-virtualenv-prompt
znap source ohmyzsh/ohmyzsh plugins/{conda-env,git}
znap prompt dotfiles camillescott

export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim', 'nvim')
znap source lukechilds/zsh-nvm

[[ -r $HOME/.local/bin/nvim.appimage ]] || get_nvim
[[ -h $HOME/.config/nvim ]] || (mkdir -p $HOME/.config && ln -s $HOME/dotfiles/nvim $HOME/.config/nvim)
[[ -r $HOME/.terminfo/x/xterm-kitty ]] || (mkdir -p $HOME/.terminfo/x && curl -L https://github.com/kovidgoyal/kitty/blob/f82c1a942e1df59fd0e37eb4f8a4448a29df95b6/terminfo/x/xterm-kitty > $HOME/.terminfo/x/xterm-kitty)
[[ -r $HOME/.config/git/config ]] || (mkdir -p $HOME/.config/git && cp $HOME/dotfiles/gitconfig $HOME/.config/git/config)
[[ -r $HOME/.config/tmux/tmux.conf ]] || (mkdir -p $HOME/.config/tmux && ln -s $HOME/dotfiles/tmux.conf $HOME/.config/tmux/tmux.conf)
[[ -r $HOME/.ssh/config ]] || (mkdir -p $HOME/.ssh && ln -s $HOME/dotfiles/sshconfig $HOME/.ssh/config)
[[ `nvm current` != 'system\n' ]] || nvm install v16.18.0

znap source ohmyzsh/ohmyzsh plugins/git
znap source ohmyzsh/ohmyzsh plugins/colored-man-pages
znap source ohmyzsh/ohmyzsh plugins/colorize
znap source ohmyzsh/ohmyzsh plugins/catimg
znap source ohmyzsh/ohmyzsh plugins/extract
znap source ohmyzsh/ohmyzsh plugins/git-extras
znap source ohmyzsh/ohmyzsh plugins/gitfast
znap source ohmyzsh/ohmyzsh plugins/pip
znap source ohmyzsh/ohmyzsh plugins/ssh-agent
znap source ohmyzsh/ohmyzsh plugins/fzf

znap source zsh-users/zsh-syntax-highlighting


# vim: set filetype=zsh: 
