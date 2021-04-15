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

if [ -z "$DEVICE_TYPE" ]; then
    echo "Device type is not set. Please use -d option" >&2
    exit 5
fi

if [ -z "$EPICS_CA_MAX_ARRAY_BYTES" ]; then
    EPICS_CA_MAX_ARRAY_BYTES="10000000"
fi

DMM7510_TYPE=$(echo ${DEVICE_TYPE} | grep -Eo "[^0-9]+");

if [ -z "$DMM7510_TYPE" ]; then
    echo "DMM7510 device type is not valid. Please check the -d option" >&2
    exit 6
fi

case ${DMM7510_TYPE} in
    DCCT)
        ST_CMD_FILE=stDCCT.cmd
        ;;

    ICT)
        ST_CMD_FILE=stICT.cmd
        ;;

    DMM)
        ST_CMD_FILE=stDMM7510.cmd
        ;;

    *)
        echo "Invalid DMM7510 type: "${DMM7510_TYPE} >&2
        exit 7
        ;;
esac

echo "Using st.cmd file: "${ST_CMD_FILE}

cd "$IOC_BOOT_DIR"

EPICS_IOC_LOG_INET="$EPICS_IOC_LOG_INET" EPICS_IOC_LOG_PORT="$EPICS_IOC_LOG_PORT" EPICS_CA_MAX_ARRAY_BYTES="$EPICS_CA_MAX_ARRAY_BYTES" IPADDR="$IPADDR" IPPORT="$IPPORT" P="$P" R="$R" "$IOC_BIN" "$ST_CMD_FILE"
