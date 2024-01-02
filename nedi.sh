#! /bin/sh

source ./env.sh

WORKDIR="${1:-$(pwd)}"

docker run -it --rm -w /root/workspace \
  -v $WORKDIR:/root/workspace \
  -v $CONFIG_HOST:$CONFIG_CONTAINER \
  -v $DATA_CORE_HOST:$DATA_CORE_CONTAINER \
  -v $DATA_LAZY_HOST:$DATA_LAZY_CONTAINER \
  $IMAGE sh -uelic 'nvim'
