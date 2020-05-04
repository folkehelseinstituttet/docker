#!/bin/bash
source $WORKSPACE/bin/R_VERSION.sh
source /etc/environment

podman login docker.io -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

podman push fhix/dbase:$RVERSION
