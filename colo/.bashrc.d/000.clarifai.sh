if [ -e $HOME/work/clarifai/scripts/amazon/config/ubuntu/.bashrc ];
then
  source $HOME/work/clarifai/scripts/amazon/config/ubuntu/.bashrc
fi

export PYTHONPATH=$CLARIFAI_ROOT:$CLARIFAI_ROOT/utils:$PYTHONPATH
export CLARIFAI_DEPLOY=local-k8s-$USER

if [ `uname` = "Darwin" ]; then
    alias kl='kubectl --context=docker-for-desktop --namespace=local-k8s-$USER'
    alias kt='kubectl --context=docker-for-desktop --namespace=test-k8s-$USER'
    export CLARIFAI_K8S_CLUSTER="laptop"
elif [ `uname` = "Linux" ]; then
    alias kl='kubectl --context=colo --namespace=local-k8s-$USER'
    alias kt='kubectl --context=colo --namespace=test-k8s-$USER'
    export CLARIFAI_K8S_CLUSTER="colo"
fi


