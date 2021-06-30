import requests
import sys
import json
req = requests.put(sys.argv[4], data=json.dumps({"content": sys.argv[2], "message": sys.argv[3]}), headers={"Authorization": "token " + sys.argv[1]})
if (req.status_code != 201):
    print("Error")
