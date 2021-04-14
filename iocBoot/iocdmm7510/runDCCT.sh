#!/bin/sh

set -e
set +u

# Source environment
. ./checkEnv.sh

# Parse command-line options
. ./parseCMDOpts.sh "$@"

# Check last command return status
if [ $? -ne 0 ]; then
	echo "Could not parse command-line options" >&2
	exit 1
fi

if [ -z "$IPADDR" ]; then
    echo "IP address not set. Please use -i option or set \$IPADDR environment variable" >&2
    exit 3
fi

if [ -z "$IPPORT" ]; then
    IPPORT="5025"
fi

if [ -z "$EPICS_CA_MAX_ARRAY_BYTES" ]; then
    EPICS_CA_MAX_ARRAY_BYTES="10000000"
fi

cd "$IOC_BOOT_DIR"

EPICS_IOC_LOG_INET="$EPICS_IOC_LOG_INET" EPICS_IOC_LOG_PORT="$EPICS_IOC_LOG_PORT" EPICS_CA_MAX_ARRAY_BYTES="$EPICS_CA_MAX_ARRAY_BYTES" IPADDR="$IPADDR" IPPORT="$IPPORT" P="$P" R="$R" "$IOC_BIN" stDCCT.cmd
