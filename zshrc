export PATH=$HOME/.local/bin:/usr/local/bin:$PATH
zstyle :omz:plugins:ssh-agent agent-forwarding on

source $HOME/.local/share/zsh/zsh-snap/znap.zsh
source ~znap/dotfiles/site.zsh

znap source ohmyzsh/ohmyzsh lib/{git,prompt_info_functions,theme-and-appearance,history}
znap source tonyseek/oh-my-zsh-virtualenv-prompt
znap source ~znap/dotfiles
znap prompt ~znap/dotfiles camillescott

export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim', 'nvim')
znap source lukechilds/zsh-nvm

znap source ohmyzsh/ohmyzsh plugins/git
znap source ohmyzsh/ohmyzsh plugins/colored-man-pages
znap source ohmyzsh/ohmyzsh plugins/colorize
znap source ohmyzsh/ohmyzsh plugins/catimg
znap source ohmyzsh/ohmyzsh plugins/extract
znap source ohmyzsh/ohmyzsh plugins/git-extras
znap source ohmyzsh/ohmyzsh plugins/pip
znap source ohmyzsh/ohmyzsh plugins/ssh-agent
znap source ohmyzsh/ohmyzsh plugins/fzf

znap source zsh-users/zsh-syntax-highlighting
znap source unixorn/fzf-zsh-plugin

echo
