#! /bin/sh

if [[ $# -lt 1 ]]; then
  echo "expected arg to define an executable app"
  exit 1
fi

CONFIG_DIR=$HOME/.config/nedi/$1
if [[ ! -d $CONFIG_DIR ]]; then
  echo "app $1 not found"
  exit 1
fi

source $CONFIG_DIR/launch.cfg

WORKDIR_HOST="${2:-$(pwd)}"
WORKDIR_CONTAINER=/root/workspace

docker run -it --rm \
  --dns 8.8.8.8 \
  -w $WORKDIR_CONTAINER \
  -v $WORKDIR_HOST:$WORKDIR_CONTAINER \
  -v $LUA_CONFIG_HOST:$LUA_CONFIG_CONTAINER \
  -v $DATA_CORE_HOST:$DATA_CORE_CONTAINER \
  -v $DATA_LAZY_HOST:$DATA_LAZY_CONTAINER \
  $IMAGE /sh -uelic 'nvim'
