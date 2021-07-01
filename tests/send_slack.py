import requests
import json
import sys
payload = {"text": sys.argv[1]}
req = requests.post(sys.argv[2], data=json.dumps(payload))
print(req.text)
