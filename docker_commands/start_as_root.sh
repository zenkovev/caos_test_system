#!/bin/bash

docker start -a caos_test_docker &
until [ "`docker inspect -f {{.State.Running}} caos_test_docker`" == "true" ]; do
    sleep 0.5;
done;
docker exec -it --user root caos_test_docker /bin/bash
