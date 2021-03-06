#!/bin/bash

NAME="valheim_test"
#name to use for running server container

#Docker images
##############
STEAM="docker.io/steamcmd/steamcmd:latest"
#image for steamcmd

UBUNTU="docker.io/ubuntu:latest"
#image used to run server
#ubuntu was my prefence, but you could easily use another image such as debian or centos

VALHEIM_IMAGE_NAME="valheim"
#named used for image through podman build command
VALHEIM="localhost/$VALHEIM_IMAGE_NAME:latest"
#full name to reference when calling image to run server

#Server Data
############
REMOTE_DATA="/app"
#where in the container to mount the game files
#if you change this, update force_install_dir variable in config/update_script.conf

LOCAL_DATA="/disk2/steamcmd_test"
#where to store your game files
#IMO it is more practical to mount the game files into a container then to copy them into a image

#SteamCMD update script
#######################
UPDATE_SCRIPT="valheim_update_script.conf"
LOCAL_UPDATE_SCRIPT="./config/$UPDATE_SCRIPT"
#REMOTE_UPDATE_SCRIPT="$REMOTE_DATA/$UPDATE_SCRIPT"
REMOTE_UPDATE_SCRIPT="/etc/$UPDATE_SCRIPT"
#this is meant to help with redundancy and make the podman run statement cleaner
#the location can be anywhere really, but i didnt want to put it int the same
  #location as the mounted server data in "/app"

#SERVER PORTS
#############
#ports to forward
H_PORT="2456-2458"
#host ports, your host os
C_PORT=$H_PORT
#container ports to publish; I kept them the same

#test purposes
#H_PORT="2459-2461" #test
#C_PORT="2456-2458" #test

#from the documentation I found in 'Valheim Dedicated Server Manual.pdf':
  #"The default Port Range that the Server uses is 2456-2458"
  #unclear if this should be tcp, udp, or both
  #my testing has lead me to beleive this is only UDP
  #the game is bound to 2456, steam servers at 2467, and unsure about 2458
  #if connecting through the steam server viewer, use port 2467
