#! /bin/sh

declare app=""
declare force=false

function usage() {
  echo "Usage: install.sh [<options>]"
  echo ""
  echo "Options:"
  echo "    -h, --help     Print this help message"
  echo "    -f, --force    Install with removing old data"
  echo "    -a, --app      Choose an app to install"
}

function parse_args() {
  while getopts hfa: param; do
    case $param in
      h | help)
        usage
        exit 0
        ;;
      f | force)
        force=true
        ;;
      a | app)
        app=$OPTARG
        echo "app to install: lunedi $app"
        ;;
    esac
  done
}

function install_app() {
  docker buildx build ./app/$APP --tag=$IMAGE_TAG --network=host

  if [[ ! -d $DATA_HOST ]]; then
    mkdir -p $DATA_HOST
  fi

  if [[ ! -d $CACHE_HOST ]]; then
    mkdir -p $CACHE_HOST
  fi

  if [[ ! -d $CONFIG_HOST ]]; then
    mkdir -p $CONFIG_HOST
  fi

  id=$(docker create -q $IMAGE_TAG)
  docker cp $id:$APP_DATA_CONTAINER $APP_DATA_HOST
  docker cp $id:$APP_CACHE_CONTAINER $APP_CACHE_HOST
  docker cp $id:$APP_CONFIG_CONTAINER $APP_CONFIG_HOST
  docker rm -v $id

  profile=$APP_CONFIG_HOST/.profile
  target_bin=$HOME/.local/bin/$APP

  echo "# .commonrc" >> $profile
  cat ./.commonrc >> $profile

  echo "" >> $profile
  echo "# .apprc" >> $profile
  cat ./app/$APP/.apprc >> $profile

  ln -sf $(pwd)/launch.sh $target_bin
  chmod ugo+x $target_bin
}

function main() {
  parse_args "$@"

  if [[ ! -d ./app/$app ]]; then
    echo "app $app not found"
    exit 1
  fi

  source ./.commonrc
  source ./app/$app/.apprc

  if [[ $app != $APP ]]; then
    echo "unexpected app:APP: $app:$APP"
    exit 1
  fi

  if $force; then
    echo "cleaning installation dirs…"
    sudo rm -rf $APP_DATA_HOST
    sudo rm -rf $APP_CACHE_HOST
    sudo rm -rf $APP_CONFIG_HOST
  fi

  install_app
  echo "done"
}

main "$@"
