#!/bin/sh

# Run run*.sh scripts with procServ
/usr/local/bin/procServ -f -n DMM7510 -i ^C^D 20000 ./runGenericCT.sh "$@"
