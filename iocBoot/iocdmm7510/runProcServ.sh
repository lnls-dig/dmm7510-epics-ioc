#!/bin/sh

# Parse command-line options
. ./parseCMDOpts.sh "$@"

# Use defaults if not set
if [ -z "${DMM7510_DEVICE_TELNET_PORT}" ]; then
   DMM7510_DEVICE_TELNET_PORT=20000
fi

# Run run*.sh scripts with procServ
/usr/local/bin/procServ -f -n DMM7510${DMM7510_INSTANCE} -i ^C^D ${DMM7510_DEVICE_TELNET_PORT} ./runGenericCT.sh "$@"
