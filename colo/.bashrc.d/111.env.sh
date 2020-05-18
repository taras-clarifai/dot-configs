alias vib="vim -u NONE"

export EDITOR="vim -u NONE"
export MYVIMRC='$HOME/.vim8rc'

alias myvim="VIMINIT='source $MYVIMRC' vim8"

export GOPATH=$CLARIFAI_ROOT/go
export GO15VENDOREXPERIMENT=1

export PATH="$PATH:~/.local/bin:$GOPATH/bin"
