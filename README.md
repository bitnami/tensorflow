# Tensorflow

This is a convenience repo to keep track of tensorflow hacks

## Seed inception model

```
$ kubectl create -f seed.yaml
```

Once job is complete, run a Pod that loads the pvc containing the model

```
$ kubectl create -f inception.yaml
```

## Build tensorflow serving in docker

This is based of this [Dockerfile](https://github.com/tensorflow/serving/blob/master/tensorflow_serving/tools/docker/Dockerfile.devel)
But switching to `bitnami/minideb:jessie`

```
$ docker build -t tensorflow -f Dockerfile.minideb .
```

Then (note the memory requirement of the container).

```
$ docker run -it -m 3g tensorflow /bin/bash
```

In the container, follow the official [instructions](http://tensorflow.github.io/serving/serving_inception)

## Deploy chart

```
$ cd chart
$ helm install tensorflow/
```
