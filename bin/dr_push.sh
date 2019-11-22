#!/bin/bash
source $WORKSPACE/bin/R_VERSION.sh

docker push fhix/dr:$RVERSION

docker tag fhix/dr:$RVERSION fhix/dr:latest
docker push fhix/dr:latest

docker run --rm fhix/dr:latest R -e "library(brain)"
