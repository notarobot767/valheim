#!/bin/bash

cd "${0%/*}"
#change directory relative to script

podman build -f ./config/dockerfile.conf \
        -t valheim \
        .
