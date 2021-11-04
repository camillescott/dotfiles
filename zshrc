# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
zstyle :omz:plugins:ssh-agent agent-forwarding on

source $HOME/.local/share/zsh/zsh-snap/znap.zsh

znap source ohmyzsh/ohmyzsh lib/{git,theme-and-appearance,prompt_info_functions,history}
znap source tonyseek/oh-my-zsh-virtualenv-prompt
znap source camillescott/dotfiles
znap prompt camillescott/dotfiles camillescott

znap source ohmyzsh/ohmyzsh plugins/git
znap source ohmyzsh/ohmyzsh plugins/colored-man-pages
znap source ohmyzsh/ohmyzsh plugins/colorize
znap source ohmyzsh/ohmyzsh plugins/catimg
znap source ohmyzsh/ohmyzsh plugins/extract
znap source ohmyzsh/ohmyzsh plugins/git-extras
znap source ohmyzsh/ohmyzsh plugins/pip
znap source ohmyzsh/ohmyzsh plugins/ssh-agent

znap source zsh-users/zsh-syntax-highlighting
znap source unixorn/fzf-zsh-plugin

