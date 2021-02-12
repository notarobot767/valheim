#!/bin/bash

#Order of operation
#  cd to directory relative to script
#  source variables from ./config.conf
#  pull latest steamcmd image
#  stop valheim server container instance if running
#  run update in a temporal container

cd "${0%/*}"
#change directory relative to script

source ./config.conf
#source variables from config.conf

IMAGE=$STEAM
NAME=$VALHEIM
#point name and image to vars from config.conf
#we could just use the vars from config.conf, but
  #i prefer to be consistent in my scripts with the words image and name

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
#-it
  #the process should not take long depending on your bandwidth, so
  #interactive mode will allow you see the progress and any errors
  #if you prefer it to be headless, just change -it to -d
#--rm
  #sole purpose of container image is to update our local server data,
  #so no need to keep the container after it finishes.
#-v $LOCAL_DATA:$REMOTE_DATA
  #this mounts our local server data folder into the perceived container location.
  #purely out of habbit, i assigned the remote destination to be /app from config.conf
#-v $LOCAL_UPDATE_SCRIPT:$REMOTE_UPDATE_SCRIPT:ro
  #this mounts a file for the steamcmd +runscript file.
  #we could type out the arguments here instead, but i prefer to use a script.
  #in order to use the script, we have to get the file into the container for
  #steamcmd to find it, since the relative filesystem for steamcmd will be the container instance
#$IMAGE +runscript $REMOTE_UPDATE_SCRIPT
  #this calls the image to instanciate (steamcmd) and then run the following commands
  #+runscript and it's script file on the container
