export PATH=$PATH:/opt/hpccf/bin
module load -s conda
[[ `hostname` == accounts-dev ]] && conda activate cheeto-dev
