if [[ ! -r $ZNAP_HOME/znap.zsh ]]
then
    mkdir -p $ZNAP_HOME
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git $ZNAP_HOME
fi

if [[ ! -h $ZSH_HOME/dotfiles ]]
then
    ln -fs $HOME/dotfiles $ZSH_HOME/dotfiles
fi

export NVIM_APPIMAGE=${NVIM_APPIMAGE:='https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage'}
function get_nvim() {
    mkdir -p $HOME/.local/bin
    curl -L $NVIM_APPIMAGE > $HOME/.local/bin/nvim.appimage
    chmod +x $HOME/.local/bin/nvim.appimage
    ln -s $HOME/.local/bin/nvim.appimage $HOME/.local/bin/nvim
}

[[ -r $HOME/.local/bin/nvim.appimage ]] || get_nvim
[[ -h $HOME/.config/nvim ]] || (mkdir -p $HOME/.config && ln -s $HOME/dotfiles/nvim $HOME/.config/nvim)
[[ -r $HOME/.terminfo/x/xterm-kitty ]] || (mkdir -p $HOME/.terminfo/x && curl -L https://github.com/kovidgoyal/kitty/blob/f82c1a942e1df59fd0e37eb4f8a4448a29df95b6/terminfo/x/xterm-kitty > $HOME/.terminfo/x/xterm-kitty)
[[ -r $HOME/.config/git/config ]] || (mkdir -p $HOME/.config/git && cp $HOME/dotfiles/gitconfig $HOME/.config/git/config)
[[ -r $HOME/.config/tmux/tmux.conf ]] || (mkdir -p $HOME/.config/tmux && ln -s $HOME/dotfiles/tmux.conf $HOME/.config/tmux/tmux.conf)
[[ -r $HOME/.ssh/config ]] || (mkdir -p $HOME/.ssh && ln -s $HOME/dotfiles/sshconfig $HOME/.ssh/config)
[[ `nvm current` != 'system\n' ]] || nvm install v16.18.0

touch $ZSH_HOME/setup-done
