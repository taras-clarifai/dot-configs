CLARIFAI_ZSH=$HOME/work/clarifai/scripts/amazon/config/macos/.zshrc
if [ -e "$CLARIFAI_ZSH" ];
then
  source "$CLARIFAI_ZSH"
fi

export PYTHONPATH=$CLARIFAI_ROOT:$CLARIFAI_ROOT/utils:$PYTHONPATH
export CLARIFAI_DEPLOY=local-k8s-$USER

alias l='kubectl --context=docker-for-desktop --namespace=local-k8s-$USER'
alias t='kubectl --context=docker-for-desktop --namespace=test-k8s-$USER'
export CLARIFAI_K8S_CLUSTER="laptop"

# HELPER_PRINTS=false . $CLARIFAI_ROOT/infra/k8s/local/helpers.sh
