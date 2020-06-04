#!/bin/bash

imageName="langarica/my-trades"
version=$(grep -w -i '"version"' package.json | cut -d '"' -f 4)
img1=$imageName:d-$version
img2=$imageName:d-latest
docker build -t $img1 -t $img2 .
built=$?
if [ "$built" == 0 ]; then        
    docker push $imageName:r-$version
    docker push $imageName:latest
    echo 'Dev -v'$version' creation COMPLETED'
else
    echo 'A problem ocurred with the image creation'
fi