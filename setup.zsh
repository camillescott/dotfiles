if [[ ! -r $ZNAP_HOME/znap.zsh ]]
then
    mkdir -p $ZNAP_HOME
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git $ZNAP_HOME
fi

if [[ ! -h $ZSH_HOME/dotfiles ]]
then
    ln -fs $HOME/dotfiles $ZSH_HOME/dotfiles
fi

touch $ZSH_HOME/setup-done
