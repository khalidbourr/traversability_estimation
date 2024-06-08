#!/bin/bash

# Allowing local connections to the X server
xhost +SI:localuser:root

# Command to run the Docker container with GPU and display settings
docker run --gpus all -it \
    --env="DISPLAY=$DISPLAY" \
    --env="XDG_RUNTIME_DIR=/tmp" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="ros-tools:/root" \
    ros-traversability \
    /bin/bash

# Optionally, reset the X server settings
xhost -SI:localuser:root

