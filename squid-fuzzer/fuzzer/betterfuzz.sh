#!/bin/bash

cd /fuzzer/

# Loop the fuzzing until squid crashes.
# "Triplebuffering" of testcase directories is used so
# that the crashing testcase is not accidentally deleted due to
# testcase re-generation race condition.
while true; do

    # Create 800 test cases to case1
    echo "$(date): Deleting case1 testcases and creating 800 new ones!"
    rm -rf case1/*
    for file in $(ls *.smp); do
        cat $file |radamsa -o case1/fuzz-$file-%n.%s -n 100
    done

    # Run the fuzzing
    for test in $(ls case1/*); do
        cat $test |ncat 127.0.0.1 3128 >/dev/null;
        pgrep "startsquid" || exit
    done

    # Create 800 test cases to case2
    echo "$(date): Deleting case2 testcases and creating 800 new ones!"
    rm -rf case2/*
    for file in $(ls *.smp); do
        cat $file |radamsa -o case2/fuzz-$file-%n.%s -n 100
    done

    # Run the fuzzing
    for test in $(ls case2/*); do
        cat $test |ncat 127.0.0.1 3128 >/dev/null;
        pgrep "startsquid" || exit
    done

    # Create 800 test cases to case3
    echo "$(date): Deleting case3 testcases and creating 800 new ones!"
    rm -rf case3/*
    for file in $(ls *.smp); do
        cat $file |radamsa -o case3/fuzz-$file-%n.%s -n 100
    done

    # Run the fuzzing
    for test in $(ls case3/*); do
        cat $test |ncat 127.0.0.1 3128 >/dev/null;
        pgrep "startsquid" || exit
    done

    echo "$(date): All done fuzzing 2400 different testcases in case1&case2&case3"
    echo "$(date): Starting again from case1!"
done
