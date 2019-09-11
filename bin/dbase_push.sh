#!/bin/bash
source $WORKSPACE/bin/R_VERSION.sh

docker push fhix/dbase:$RVERSION
