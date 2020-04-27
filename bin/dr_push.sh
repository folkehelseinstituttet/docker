#!/bin/bash
source $WORKSPACE/bin/R_VERSION.sh

sudo podman push fhix/dr:$RVERSION

sudo podman tag fhix/dr:$RVERSION fhix/dr:latest
sudo podman push fhix/dr:latest
