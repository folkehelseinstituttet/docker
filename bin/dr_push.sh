#!/bin/bash
source $WORKSPACE/bin/R_VERSION.sh
source /etc/environment

sudo podman login docker.io -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
sudo podman push fhix/dr:$RVERSION

sudo podman tag fhix/dr:$RVERSION fhix/dr:latest
sudo podman push fhix/dr:latest
