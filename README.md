spindra
========

Docker container for CTFs

```
docker run -dit --rm \
    --name spindra \
    -e DISPLAY=$DISPLAY \
    -e PULSE_SERVER=unix:/tmp/pulseaudio.socket \
    -e PULSE_COOKIE=/tmp/pulseaudio.cookie \
    -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
    -v $HOME/Downloads/spindra:/data \
    -v $HOME/.web/pulseaudio.socket:/tmp/pulseaudio.socket \
    -v $HOME/.web/pulseaudio.client.conf:/etc/pulse/client.conf \
    -v /dev/shm:/dev/shm \
    --device /dev/snd \
    --device /dev/dri \
    --net=container:openvpn \
    spindra

docker exec -it spindra bash
```
