spindra
========

Docker container for CTFs

```
sudo docker run -it --rm \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/spindra:/data \
    --cap-add NET_ADMIN \  # Not required but useful
    --cap-add SYS_PTRACE \ # Not required but useful
    wh1t3f0x/spindra
```
