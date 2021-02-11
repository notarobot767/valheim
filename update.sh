#!/bin/bash

#Order of operation
#  cd to directory relative to script
#  source variables from ./config.conf
#  pull latest steam image
#  stop valheim server container instance if running
#  run update in a temporal container

cd "${0%/*}"
#change directory relative to script

source ./config.conf
#source variables from config.conf

IMAGE=$STEAM
NAME=$VALHEIM
#point name and image to vars from config.conf

#SteamCMD update script
#######################
UPDATE_SCRIPT="valheim_update_script.conf"
LOCAL_UPDATE_SCRIPT="./config/$UPDATE_SCRIPT"
REMOTE_UPDATE_SCRIPT="$REMOTE_DATA/$UPDATE_SCRIPT"
#this is meant to help with redundancy and make the podman run statement cleaner

podman pull $IMAGE
#update SteamCMD image prior to using
#this image updates frequently, so IMO it is best practice to pull latest image of SteamCMD,
  #and run container instance of it instead of creating a custom image with a dockerfile

podman stop $NAME
#stop any instance of the server container
#in run.sh, the server will be name will be linked to $VALHEIM

podman run -it \
  --rm \
  -v $LOCAL_DATA:$REMOTE_DATA \
  -v $LOCAL_UPDATE_SCRIPT:$REMOTE_UPDATE_SCRIPT:ro \
  $IMAGE +runscript $REMOTE_UPDATE_SCRIPT
