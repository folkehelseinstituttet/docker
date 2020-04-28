#!/bin/bash
source $WORKSPACE/bin/R_VERSION.sh
source /etc/environment

sudo podman login docker.io -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

sudo podman push fhix/dbase:$RVERSION
