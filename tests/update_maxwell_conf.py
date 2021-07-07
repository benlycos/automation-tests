import ConfigParser
import sys

CORE_CONFIG_PATH="/opt/watchy/bond007-core/conf/maxwell.cfg"
coreconfigfile = ConfigParser.ConfigParser()
coreconfigfile.read(CORE_CONFIG_PATH)
coreconfigfile.set("maxwells", "list", sys.argv[1])
coreconfigfile.remove_section("maxchn01.watchy.in")
coreconfigfile.remove_section("maxdel01.watchy.in")
coreconfigfile.remove_section("maxblr01.watchy.in")
coreconfigfile.remove_section("maxbom01.watchy.in")
with open(CORE_CONFIG_PATH, 'w') as fp:
    coreconfigfile.write(fp)
print("Setting the maxwel server to " + coreconfigfile.get("maxwells", "list"))

