# dotfiles

my dotfiles.

## installation

install [zsh-snap](https://github.com/marlonrichert/zsh-snap#installation):

  mkdir -p ~/.local/share/zsh & cd ~/.local/share/zsh
  git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git

Install figlet:

  sudo apt install figlet
  
clone dotfiles:

  cd && git clone git clone git@github.com:camillescott/dotfiles.git

backup old `.zshrc` and link in new one from repo:

  mv ~/.zshrc ~/.zshrc.bank
  ln dotfiles/zshrc .zshrc
