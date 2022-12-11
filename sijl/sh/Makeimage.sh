#!/usr/bin/env sh

cd ..
result=${PWD##*/}

if [[ "$(docker images -q $result 2> /dev/null)" == "" ]]; then
docker build -t $result .
fi

