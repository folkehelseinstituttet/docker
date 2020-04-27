#!/bin/bash
source $WORKSPACE/bin/R_VERSION.sh

sudo podman push fhix/dbase:$RVERSION
