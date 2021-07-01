import requests
import json
import sys
payload = {"text": sys.argv[1]}
req = requests.post("https://hooks.slack.com/services/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", data=json.dumps(payload))
