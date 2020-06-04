#!/bin/bash

imageName="my-trades-local"
docker pull langarica/my-trades:dp-latest
docker build -t $imageName --target dev .
built=$?
if [ "$built" == 0 ]; then        
    echo 'Dev image:'$imageName' creation COMPLETED'
else
    echo 'A problem ocurred with the image creation'
fi