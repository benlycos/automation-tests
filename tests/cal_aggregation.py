import os
import json
import sys

print(sys.argv[1])
final_data = {}
for file in os.listdir("./speedtest-result/"):
    try:
        if file.endswith(".json"):
            json_path = os.path.join("./speedtest-result/", file)
            split_data = json_path.split("--")
            inter = split_data[0].split("/")[2]
            d_or_u = split_data[1]
            if not(inter in final_data):
                final_data[inter] = {}
            f = open(json_path, 'r')
            data = json.load(f)
            final_data[inter][d_or_u] = data[d_or_u] / 1000000.0
            f.close()
    except:
        pass

combined_data = final_data['all']
final_data.pop('all')
accumulated_upload = 0.0
accumulated_download = 0.0
print(final_data)
for keys in final_data:
    accumulated_upload += final_data[keys]['upload']
    accumulated_download += final_data[keys]['download']
final_data.update(combined_data)
final_data['upload_aggr_perc'] = (combined_data['upload'] / accumulated_upload) * 100
final_data['download_aggr_perc'] = (combined_data['download'] / accumulated_download) * 100
with open('./speedtest-result/final_result--' + sys.argv[1] + '.json', 'w') as f1:
    json.dump(final_data, f1, sort_keys=True, indent=4)
