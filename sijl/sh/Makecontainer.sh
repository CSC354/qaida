#!/usr/bin/env sh

cd .. # Since using make
result=${PWD##*/}

docker run --rm --net debate-net --name $result -d $result
