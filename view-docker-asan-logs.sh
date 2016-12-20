#!/bin/bash

for container in $(docker ps -a -q); do docker exec -it $container cat /fuzzer/asan.log |grep -i Address; done
