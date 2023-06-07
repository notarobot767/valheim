FROM docker.io/library/ubuntu:22.04

ENV TZ="US/Hawaii"
#set timezone variable
#https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
  #set local timezone
  \
  apt-get update && apt-get upgrade -y && apt-get install -y tzdata \
    #update, upgrade, and set time
    \
    ca-certificates \
    #necessary for TLS when connecting to steam servers
      \
    libatomic1 libpulse-dev libpulse0 && \
    #required from the manual itself
  \
  rm -rf /var/lib/apt/lists/*
  #remove apt package cache

WORKDIR /app
#personal preference, run docker app in the /app folder

ENTRYPOINT ["./start_server_custom.sh"]

EXPOSE 2456/udp
EXPOSE 2457/udp
EXPOSE 2458/udp

LABEL maintainer="human" \
  org.label-schema.name="Unturned" \
  org.label-schema.vendor="OG Networks" \
  org.label-schema.build-date="2023-05-18" \
  org.label-schema.description="Custom OS for Valheim Server" \
  org.label-schema.url="https://www.ogrydziak.net" \
  org.label-schema.vcs-ref="https://github.com/notarobot767/prod_docker_services_stack"