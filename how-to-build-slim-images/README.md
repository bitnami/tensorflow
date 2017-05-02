You can build slimmer server and client images using these dockerfiles. It is necessary to first run the slimmer-images.sh script in order to retrieve the required files from the current image.

Then you can build the client and server images with these commands:

```
$ docker build -t tensorflow-server-slim -f Dockerfile.server .
```


```
$ docker build -t tensorflow-client-slim -f Dockerfile.client .
```