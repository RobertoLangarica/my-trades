#!/bin/bash

wdir=$(pwd)
mkdir temp
tmpDir=$? 
imageName="langarica/my-trades"
img1=$imageName:r-$version
img2=$imageName
if [ "$tmpDir" == 0 ]; then
    cd temp
    git clone --single-branch --branch release https://github.com/RobertoLangarica/my-trades.git
    clone=$?
    if [ "$clone" == 0 ]; then
        cd my-trades/frontend
        version=$(grep -w -i '"version"' package.json | cut -d '"' -f 4)
        docker pull $imageName:dp-latest
        docker build -t $img1 -t $img2 .
        built=$?
        if [ "$built" == 0 ]; then
            docker push $img1
            docker push $img2
        fi
    fi
    cd $wdir
    # git removes the write access to some files
    chmod -R +w temp
    rm -r temp

    if [ "$built" == 0 ]; then
        echo 'Build v-'$version' COMPLETED'
    else
        echo 'A problem ocurred while creating the build image'
    fi

else 
echo 'Unable to create directory temp'
fi 
