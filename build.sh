#!/bin/bash

export eTAG="latest-dev"
echo $1
if [ $1 ] ; then
  eTAG=$1
fi

echo Building openfaas/faas-cli:$eTAG

docker build --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy --target release -t openfaas/faas-cli:$eTAG .

echo Building openfaas/faas-cli:$eTAG-root

docker build --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy --target root -t openfaas/faas-cli:$eTAG-root .

if [ $? == 0 ] ; then

  docker create --name faas-cli openfaas/faas-cli:$eTAG && \
  docker cp faas-cli:/usr/bin/faas-cli . && \
  docker rm -f faas-cli

else
 exit 1
fi
