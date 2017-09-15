#!/bin/bash

git clone https://github.com/markdunning/mutation-demo.git mutation-demo

chmod ugo+r mutation-demo/*.R
chmod ugo+r mutation-demo/www/*
chmod ugo+r shiny-server.conf

# build docker image
docker build --tag="crukci-bioinformatics/mutation-demo" .

# remove dangling/untagged images
#docker rmi $(docker images --filter "dangling=true" -q --no-trunc)


