#!/bin/bash

#Order of operation
#  cd to directory relative to script
#  source variables from ./config.conf
#  pull latest ubuntu image; TODO: make a docker file for this
#  run the server

cd "${0%/*}"
#change directory relative to script

source ./config.conf
#source variables from config.conf

IMAGE=$UBUNTU
NAME=$VALHEIM
#point name and image to vars from config.conf
#we could just use the vars from config.conf, but
  #i prefer to be consistent in my scripts with the words image and name

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

podman run -d \
  --name $NAME \
  -v $LOCAL_DATA:$REMOTE_DATA \
  -v $LOCAL_START_SCRIPT:$REMOTE_START_SCRIPT:ro \
  -p $H_PORT:$C_PORT \
  -p $H_PORT:$C_PORT/udp \
  $IMAGE $REMOTE_START_SCRIPT
#-d
  #if you make changes are are not sure if the server is running properly, change the -d to -it
  #-d is headless mode, and this way you do not have to keep a terminal window open for the server
  #future implementation should use a docker file to create an image for disired OS, Ubuntu in this case,
  #and use a tool like screen to allow you to attach the screen after getting a bash shell with exec.
  #screen would allow you to see the server console after connecting to the container instance
#-v $LOCAL_DATA:$REMOTE_DATA
  #this mounts our local server data folder into the perceived container location.
  #purely out of habbit, i assigned the remote destination to be /app from config.conf
#-v $LOCAL_START_SCRIPT:$REMOTE_START_SCRIPT:ro
  #this mounts a file for the steamcmd +runscript file.
  #again, we could type out the arguments here instead, but i prefer to use a script.
  #in order to use the script, we have to get the file into the container for
  #the container OS to find it
#$IMAGE +runscript $REMOTE_UPDATE_SCRIPT
  #this calls the Ubuntu image to instanciate a container and then run the start script
