#!/bin/bash

(echo y) | docker system prune

source $WORKSPACE/bin/R_VERSION.sh
docker push fhix/dbase:$RVERSION


