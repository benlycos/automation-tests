# Automation Tests
This contains the tests that need to be performed on to zifilink device

## Tests that are integrated
Following are the tests that are integrated into our system
### Aggregation test
This checks the aggregation %. To calculate the aggregation % we calculate the upload and download of individual dongles and sum them up and divide by the upload and download speed that is got when all the connected re combined together.
To run the test run the following commands
```
./run_tests.sh ap 
```
After this script is run it will create a folder called `speedtest-result` in which there will be a file which will be named like `final_result--xxxxxxxxxxxxx.json`
This file will contain the aggregated % and combined speed for upload as well as download and also the individual connection speed. 

Here is an example output
