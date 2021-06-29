#!/bin/bash

if [[ $1 == "--help" ]]
then
        echo "To run tests, Here are the commands"
        echo "run_tests.sh ap : To test aggregation"
        echo "run_tests.sh ut : To upload the test"
        exit 0
fi

if [[ $1 == "ap" ]]
then
        ./test_aggregation.sh & disown
        exit 0
fi

if [[ $1 == "ut" ]]
then
        ./upload_tests.sh
        exit 0
fi


echo "To run tests, Here are the commands"
echo "run_tests.sh ap : To test aggregation"
echo "run_tests.sh ut : To upload the test"
exit 0
