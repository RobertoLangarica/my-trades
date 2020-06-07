#!/bin/bash
image=langarica/postgres
docker build -t $image .
if [ $? ]; then
    docker push $image
fi