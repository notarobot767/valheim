#!/bin/bash

#Order of operation
#  cd to directory relative to script
#  source variables from ./config.conf
#  stop and remove any instance of container server
#  run the server from local image generated from ./build.sh

cd "${0%/*}"
#change directory relative to script

source ./config/config.conf
#source variables from config.conf

IMAGE=$VALHEIM
#point name and image to vars from config.conf
#we could just use the vars from config.conf, but
  #i prefer to be consistent in my scripts with the words image and name

podman stop $NAME
#stop any container instance of the server

podman rm $NAME
#remove the container instance of the server
#the server files are stored in LOCAL_DATA, so this is not an issue

podman run -d \
  --name $NAME \
  -v $LOCAL_DATA:$REMOTE_DATA \
  -p $H_PORT:$C_PORT \
  -p $H_PORT:$C_PORT/udp \
  $IMAGE
#-d
  #if you make changes are are not sure if the server is running properly, change the -d to -it
  #-d is headless mode, and this way you do not have to keep a terminal window open for the server
  #future implementation should use a docker file to create an image for disired OS, Ubuntu in this case,
  #and use a tool like screen to allow you to attach the screen after getting a bash shell with exec.
  #screen would allow you to see the server console after connecting to the container instance
#-v $LOCAL_DATA:$REMOTE_DATA
  #this mounts our local server data folder into the perceived container location.
  #purely out of habbit, i assigned the remote destination to be /app from config.conf
#-p
  #these are the official listed ports for valheim dedicated server
  #unclear if this range should be tcp, udp, or both
#$IMAGE
  #the local image was built with an entry point to automatically run the start script upon boot
