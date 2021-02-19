ln -fs vimrc $HOME/.vimrc
ln -fs condarc $HOME/.condarc

COLS=`tput cols`
alias center="sed  -e :a -e 's/^.\{1,'"$(( $COLS - 2 ))"'\}$/ & /;ta'"
alias div="tput sgr 0; tput bold; tput setaf 4; printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =; tput sgr 0"
alias smalldiv="tput bold; tput setaf 4; echo '********************' | center; tput sgr 0"


source zshrc.local.zsh
