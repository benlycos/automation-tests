# Automation Tests
This contains the tests that need to be performed on to zifilink device

## Tests that are integrated
Following are the tests that are integrated into our system

### One time setup that need to be done
Following are the commands that need to be run unless I tell there is an update in the script. If I tell there is an update in the script to delete the directory `automation-tests-main` and then run the following scripts 
```
#Get the code only need to be done one in a device if automation-tests folder already exists remove it and run the below command to update a new scripts
wget https://github.com/benlycos/automation-tests/archive/refs/heads/main.tar.gz
tar -xvf main.tar.gz
# deleting the tar file
rm -rf main.tar.gz
# Doing to the folder in which all the scripts are present. Scripts can only properly run in the tests folder so be in this folder before running the script
cd automation-tests-main/tests/
# Giving exec permision to all the scripts. Only need to be done once for a newly cloned script
chmod +x *.sh
```
### Aggregation test
This checks the aggregation %. To calculate the aggregation % we calculate the upload and download of individual dongles and sum them up and divide by the upload and download speed that is got when all the connected re combined together.
To run the test run the following commands
```
# Run the script You might lose the connection from the device as soon as you run the scipt. 
./run_tests.sh ap 
```
This script will take almost 3 minutes to finish running. After this script is run's it will create a folder called `speedtest-result` in which there will be a file which will be named like `final_result--xxxxxxxxxxxxx.json`
This file will contain the aggregated % and combined speed for upload as well as download and also the individual connection speed. 

Here is an example output

```
{
    "download": 4.900931155199762, # combined download speed
    "download_aggr_perc": 123.55514358805553, # aggregation % for download
    "net0": {
        "download": 2.2865725495222233, #download speed of net0
        "upload": 4.34064934567907 #upload speed of net0
    }, 
    "net1": {
        "download": 1.4033226019150244, #download speed of net1
        "upload": 3.9355438229088713 #upload speed of net1
    }, 
    "net2": {
        "download": 0.2766990451912045, #download speed of net2
        "upload": 3.7842340394223486 #upload speed of net2
    }, 
    "upload": 10.574414844582805, combined upload speed 
    "upload_aggr_perc": 87.67860924163195 # aggregation % for upload
}
```
The latest tests are always present in the `speedtest-result` folder. When new test results are generated old test results are moved to folder named `old_test`.
If you feel there is some problem with the test results then you can check the log files present in the `speedtest-result` folder. The log files contains output of `route -n` before running the speedtest. From this you will be able to make sure that during a given test only that given interface is active. 


### Uploading the results
To upload the result run the following command
```
./run_tests.sh ut
```
This will upload the current tests that is been run and upload and give the link. Use that link for filing a github issue.
