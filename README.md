# dotfiles

my dotfiles.

## installation

install [zsh-snap](https://github.com/marlonrichert/zsh-snap#installation):

    mkdir -p ~/.local/share/zsh && cd ~/.local/share/zsh
    git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git

Install figlet with apt on ubuntu/debian based systems:

    sudo apt install figlet

or homebrew on MacOS:

    brew install figlet

backup existing dotfiles:

    cd
    mv .vimrc .vimrc.bak
    mv .condarc .condarc.bak

clone dotfiles:

    cd && git clone git@github.com:camillescott/dotfiles.git

backup old `.zshrc` and link in new one from repo:

    mv ~/.zshrc ~/.zshrc.bak
    ln dotfiles/zshrc .zshrc

