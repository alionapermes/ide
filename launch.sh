#! /bin/sh

if [[ $# -lt 1 ]]; then
  echo "expected arg to define an executable app"
  exit 1
fi

CONFIG_DIR=$HOME/.config/lunedi/$1
if [[ ! -d $CONFIG_DIR ]]; then
  echo "app $1 not found"
  exit 1
fi

source $CONFIG_DIR/.profile

WORKDIR_HOST="${2:-$(pwd)}"
WORKDIR_CONTAINER=/home/lunaruser/workspace

docker run -it --rm \
  --dns 8.8.8.8 \
  -w /home/lunaruser/workspace \
  -v $WORKDIR_HOST:$WORKDIR_CONTAINER \
  -v $APP_DATA_HOST:$APP_DATA_CONTAINER \
  -v $APP_CACHE_HOST:$APP_CACHE_CONTAINER \
  -v $APP_CONFIG_HOST:$APP_CONFIG_CONTAINER \
  lunedi:go sh -ueic 'lvim'
