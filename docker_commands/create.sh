#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
WORKSPACE_DIR=$SCRIPT_DIR/../workspace

docker build $SCRIPT_DIR --tag 'caos_test_docker'

docker run \
  --name caos_test_docker \
  --privileged \
  --mount src=$WORKSPACE_DIR,target=/workspace,type=bind \
  caos_test_docker \
  tail -f /dev/null &

# docker run
#   container name
#   privileged
#   mount directory
#   image name
#   for work in background mode

until [ "`docker inspect -f {{.State.Running}} caos_test_docker 2> /dev/null`"=="true" ]; do
    sleep 0.5;
done;
docker stop caos_test_docker
