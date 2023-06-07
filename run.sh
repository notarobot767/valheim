#!/bin/bash

#This script was intended as a draft to point server admins in the right direction
#Edit it to fit your needs for automation
#Refer to the official documentation and learn the docker compose CLI

#purpose
#start the server and attach screen

cd "${0%/*}"
#ensure working directory is the same as the script
#useful if calling script from another location, like a cron job
#https://stackoverflow.com/questions/6393551/what-is-the-meaning-of-0-in-a-bash-script

sudo docker compose up -d valheim_srv
#start the server in detached mode

sudo docker compose logs -f valheim_srv
#attach the server output to the using the docker compose logs command
#Note: Sending a break sequence such as ctrl + c will not stop the server, just the log display
  #running the script again will not restart/recreate the server unless the following changed
  #new image was built using: sudo docker compose build valheim_srv
  #docker-compose service modified