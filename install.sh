#! /bin/sh

source ./env.sh

docker buildx build . --tag=nedi:latest

sudo rm -rf $CONFIG_HOST
sudo rm -rf $DATA_CORE_HOST
sudo rm -rf $DATA_LAZY_HOST

id=$(docker create -q $IMAGE)
docker cp $id:$CONFIG_CONTAINER $CONFIG_HOST
docker rm -v $id

mkdir -p $DATA_CORE_HOST
mkdir -p $DATA_LAZY_HOST

sudo ln -sf $(pwd)/nedi.sh /bin/nedi
sudo chmod ugo+x /bin/nedi
