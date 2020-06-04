#!/bin/bash

imageName="langarica/my-trades"
version=$(grep -w -i '"version"' package.json | cut -d '"' -f 4)
img1=$imageName:dp-$version
img2=$imageName:dp-latest
docker build -t $img1 -t $img2 -f- . <<EOF
FROM node:13 AS dependency
# directory for the app
WORKDIR /usr/src/app

# Copy package and pacakge-lock
COPY package*.json ./

# install dependencies
RUN npm install \
    && npm install -g @quasar/cli
EOF
built=$?
if [ "$built" == 0 ]; then        
    docker push $img1
    docker push $img2
    echo 'Dependencies -v'$version' and latest creation COMPLETED'
else
    echo 'A problem ocurred with the image creation'
fi

