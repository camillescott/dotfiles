# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

source $HOME/.local/share/zsh/zsh-snap/znap.zsh

znap source ohmyzsh/ohmyzsh lib/{git,theme-and-appearance}
znap source tonyseek/oh-my-zsh-virtualenv-prompt
znap prompt camillescott/dotfiles bira

znap source ohmyzsh/ohmyzsh plugins/git
znap source ohmyzsh/ohmyzsh plugins/colorized-man-pages
znap source ohmyzsh/ohmyzsh plugins/colorize
znap source ohmyzsh/ohmyzsh plugins/git catimg
znap source ohmyzsh/ohmyzsh plugins/git extract
znap source ohmyzsh/ohmyzsh plugins/git git-extras
znap source ohmyzsh/ohmyzsh plugins/git pip

znap source zsh-users/zsh-syntax-highlighting

znap source camillescott/dotfiles


