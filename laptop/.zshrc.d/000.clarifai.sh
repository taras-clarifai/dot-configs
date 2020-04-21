CLARIFAI_ZSH=$HOME/work/clarifai/scripts/amazon/config/macos/.zshrc
if [ -e "$CLARIFAI_ZSH" ];
then
  source "$CLARIFAI_ZSH"
fi

export PYTHONPATH=$CLARIFAI_ROOT:$CLARIFAI_ROOT/utils:$PYTHONPATH
export CLARIFAI_DEPLOY=local-k8s-$USER

alias kl='kubectl --context=docker-for-desktop --namespace=local-k8s-$USER'
alias kt='kubectl --context=docker-for-desktop --namespace=test-k8s-$USER'
export CLARIFAI_K8S_CLUSTER="laptop"
export CLARIFAI_DEPLOY=local

