#!/bin/bash
source $WORKSPACE/bin/R_VERSION.sh

sudo podman login docker.io
sudo podman push fhix/dr:$RVERSION

sudo podman tag fhix/dr:$RVERSION fhix/dr:latest
sudo podman push fhix/dr:latest
