# Automation Tests
This contains the tests that need to be performed on to zifilink device

## Tests that are integrated
Following are the tests that are integrated into our system

### Aggregation test
This checks the aggregation %. To calculate the aggregation % we calculate the upload and download of individual dongles and sum them up and divide by the upload and download speed that is got when all the connected re combined together.
To run the test run the following commands

```
# This will make sure that you guys always run the latest script
wget https://raw.githubusercontent.com/benlycos/automation-tests/main/run_aggregation_percentage.sh -O - | sh
```
This script will take almost 3 minutes to finish running. After this script is run's it will create a folder called `speedtest-result` in which there will be a file which will be named like `final_result--xxxxxxxxxxxxx.json` or `final_error--xxxxxxxxxxxxx.json`. 

Error file is generated when there is an issue in getting speed test done in one of the interfaces. If error file is created follow these steps
1. Note the previous uploaded file link tha is in the `uploaded_link--xxxxxxxxxxxxx.txt` fileso that we can use it for issue referencing purpose.
2. Run the test again. 
3. If that also shows the same resut test the dongle which is giving error individually and see if the dongle if of lower bandwidth. 
4. If lower bandwidth tell that to the user and replace the dongle or see if the performace gets better
5. If the bandwidth is not the reason report issue with the test links attached.


If the tests ran successfully. This file will contain the aggregated % and combined speed for upload as well as download and also the individual connection speed. 

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

After the test is run it will automatically be uploading files to the cloud and there will be a file generated of te format `uploaded_link--xxxxxxxxxxxxx.txt`.
Which will have the link. Use that link to refer to the tests while describing the issue.

### Change the sever of a device
Run the following script

```
wget https://raw.githubusercontent.com/benlycos/automation-tests/main/change_server.sh -O - | bash
```

