#!/bin/bash
image=registry.digitalocean.com/wizard/postgres
docker build -t $image .
if [ $? ]; then
    docker push $image
fi