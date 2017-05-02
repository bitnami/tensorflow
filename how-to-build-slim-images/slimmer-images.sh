#!/bin/bash

OUTPUT_DIR=files/
CONTAINER_NAME=tensorflow-base

echo "==> Creating output dir..."
if [ ! -d $OUTPUT_DIR ] ; then
    mkdir $OUTPUT_DIR
fi

echo "==> Running base image..."
docker run -it --name $CONTAINER_NAME -d tompizmor/tensorflow-inception-v3

echo "==> Stripping server binary..."
docker exec $CONTAINER_NAME strip --strip-all /serving/bazel-bin/tensorflow_serving/model_servers/tensorflow_model_server
echo "==> Downloading server binary..."
docker cp $CONTAINER_NAME:/serving/bazel-bin/tensorflow_serving/model_servers/tensorflow_model_server files/

echo "==> Preparing client files..."
docker exec $CONTAINER_NAME rm -rf /serving/bazel-bin/tensorflow_serving/model_servers/
docker exec $CONTAINER_NAME tar czPf /serving.tar.gz /serving
docker exec $CONTAINER_NAME tar czPf /root/cache.tar.gz /root/.cache

echo "==> Downloading client files from docker image..."
docker cp $CONTAINER_NAME:/serving.tar.gz files/
docker cp $CONTAINER_NAME:/root/cache.tar.gz files/

echo "Stopping container..."
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME
