#!/bin/bash

cd /fuzzer/

echo "$(date): Starting squid!"
./startsquid.sh &

echo "$(date): Starting fuzzing! Check asan.log for crashes if this exits!"
./betterfuzz.sh
