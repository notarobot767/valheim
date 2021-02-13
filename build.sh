#!/bin/bash

cd "${0%/*}"
#change directory relative to script

source ./config/config.conf

podman build -f ./config/dockerfile.conf \
        -t $VALHEIM_IMAGE_NAME \
        .

#invoke the podman build command on the docker file in the config folder
