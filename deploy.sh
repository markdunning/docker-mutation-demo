#!/bin/bash

mkdir -p /opt/shiny/mutation-demo/logs
chmod ugo+rwx /opt/shiny/mutation-demo/logs
docker run -u shiny --rm -p 80:3838 crukci-bioinformatics/mutation-demo:latest &
sleep 2
docker ps -a
