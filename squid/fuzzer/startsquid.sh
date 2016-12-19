#!/bin/bash

cd /fuzzer/

ASAN_OPTIONS=alloc_dealloc_mismatch=0:detect_leaks=0:abort_on_error=1 squid -N -d999 > /fuzzer/asan.log 2>&1
