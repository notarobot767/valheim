#!/bin/bash

#Order of operation
#  cd to directory relative to script
#  source variables from ./config.conf
#  pull latest ubuntu image; TODO: make a docker file for this
#  run the server

cd "${0%/*}"
#change directory relative to script

source ./config.conf

IMAGE=$UBUNTU
NAME=$VALHEIM


#Mouting the start script from local (my machine) to the remote container
START_SCRIPT="valheim_start_script.sh"
LOCAL_START_SCRIPT="./config/$START_SCRIPT"
REMOTE_START_SCRIPT="$REMOTE_DATA/$START_SCRIPT"
#this is meant to help with redundancy and make the podman run statement cleaner

podman pull $IMAGE
#pull latest ubuntu image
#TODO: create a dockerfile for this

podman stop $NAME
#stop any container instance of the server

podman rm $NAME
#remove the container instance of the server
#the server files are stored in LOCAL_DATA, so this is not an issue

podman run -it \
  --name $NAME \
  -v $LOCAL_DATA:$REMOTE_DATA \
  -v $LOCAL_START_SCRIPT:$REMOTE_START_SCRIPT:ro \
  -p $H_PORT:$C_PORT \
  -p $H_PORT:$C_PORT/udp \
  $IMAGE $REMOTE_START_SCRIPT
