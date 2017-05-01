# Tensorflow

This is a convenience repo to keep track of tensorflow hacks

## Build tensorflow serving in docker

This is based of this [Dockerfile](https://github.com/tensorflow/serving/blob/master/tensorflow_serving/tools/docker/Dockerfile.devel)
But switching to `bitnami/minideb:jessie`. To follow the complete instructions for building tensorflow serving see the [official doc](http://tensorflow.github.io/serving/serving_inception)

```
$ docker build -t tensorflow -f Dockerfile.minideb .
```

Then (note the memory requirement of the container).

```
$ docker run -it -m 3g tensorflow
```

## Seed inception model

The following loads the inception model into a PVC by running a k8s job.

```
$ kubectl create -f seed.yaml
```

Once job is complete, run a Pod that loads the pvc containing the model, for example:

```
$ kubectl create -f inception.yaml
```

You can exec into it to see the model being present:

```
$ kubectl create -f inception.yaml
pod "inception" created
$ kubectl exec -ti inception /bin/sh
# cd /seed/inception-v3
# ls -l
total 424724
-rw-r----- 1 107456 5000       223 Mar  1  2016 README.txt
-rw-r----- 1 107456 5000        43 Mar  1  2016 checkpoint
-rw-r----- 1 107456 5000 434903494 Mar 14  2016 model.ckpt-157585
```

## Launch Deployment

This will create a deployment of Pods that will serve the model.
The inception model will be loaded from the _seed_ PVC using an init container.

```
$ kubectl create -f tensorflow.yaml
$ kubectl expose deployment tensorflow-serving --port=9000
```

## Deploy chart

You can also launch it with a chart.

```
$ cd chart
$ helm install tensorflow/
```
