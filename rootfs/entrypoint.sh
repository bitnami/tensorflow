#!/bin/bash

COUNTER=120
echo "==> Waiting for /seed/inception-v3 data to exists. It will wait $COUNTER s max"
while [ ! -d /seed/inception-v3/ ] && [ $COUNTER -ne 0 ]; do
    echo "==> $COUNTER"
    COUNTER=`expr $COUNTER - 1`
    sleep 1
done

if [ $COUNTER -ne 0 ]; then
  echo "==> /seed/inception-v3 data model found. Importing data ..."
  /serving/bazel-bin/tensorflow_serving/example/inception_saved_model --checkpoint_dir=/seed/inception-v3 --output_dir=/serving/inception-export
  echo "==> Data model imported. Starting inception-model service ..."
elif [ $COUNTER -eq 0 ]; then
  echo "==> Timeout waiting for data model ..."
fi

exec "$@"
