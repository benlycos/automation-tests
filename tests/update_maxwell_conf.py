import ConfigParser
import sys

CORE_CONFIG_PATH="/opt/watchy/bond007-core/conf/maxwell.cfg"
coreconfigfile = ConfigParser.ConfigParser()
coreconfigfile.read(CORE_CONFIG_PATH)
coreconfigfile.set("maxwells", "list", sys.argv[1])
with open(CORE_CONFIG_PATH, 'w') as fp:
    coreconfigfile.write(fp)
print("Setting the maxwel server to " + coreconfigfile.get("maxwells", "list"))
