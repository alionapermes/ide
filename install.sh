#! /bin/sh

TARGET_BIN=/bin/nedi

force=false
app=""

while getopts hfa: flag; do
  case $flag in
    h)
      echo "HELP"
      exit 0
      ;;
    f) force=true;;
    a)
      echo "app to install: nedi $OPTARG"
      app=$OPTARG
      ;;
  esac
done

if [[ ! -d ./app/$app ]]; then
  echo "app $app not found"
  exit 1
fi

source ./app/$app/install.cfg

if $force ; then
  echo "cleaning installation dirs…"
  sudo rm -rf $CONFIG_HOST
  sudo rm -rf $DATA_CORE_HOST
  sudo rm -rf $DATA_LAZY_HOST
fi

docker buildx build ./app/$app --tag=$IMAGE

mkdir -p $CONFIG_HOST

id=$(docker create -q $IMAGE)
docker cp $id:$LUA_CONFIG_CONTAINER $LUA_CONFIG_HOST
docker rm -v $id

cp ./app/$app/install.cfg $CONFIG_HOST/launch.cfg

mkdir -p $DATA_CORE_HOST
mkdir -p $DATA_LAZY_HOST

sudo ln -sf $(pwd)/launch.sh $TARGET_BIN
sudo chmod ugo+x $TARGET_BIN
