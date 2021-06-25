#!/bin/bash

if [[ $1 == "--help" ]]
then
        echo "run_tests.sh ap : To test aggregation"
        exit 0
fi

if [[ $1 == "ap" ]]
then
        ./test_aggregation.sh & disown
        exit 0
fi
