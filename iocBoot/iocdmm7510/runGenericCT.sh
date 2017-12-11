#!/bin/sh

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

if [ -z "$DEVICE" ]; then
    echo "Device type is not set. Please use -d option" >&2
    exit 4
fi

DMM7510_TYPE=$(echo ${DEVICE} | grep -Eo "[^0-9]+");
DMM7510_NUMBER=$(echo ${DEVICE} | grep -Eo "[0-9]+");

if [ -z "$DMM7510_TYPE" ]; then
    echo "Device type is not set. Please use -d option" >&2
    exit 5
fi

if [ -z "$DMM7510_NUMBER" ]; then
    echo "Device number is not set. Please use -d option" >&2
    exit 6
fi

# The indirect variable expansion was used for systemd integration, by using the
# file in "scripts/systemd/sysconfig", but we are not using this approach anymore.
# Instead we rely on static configuration of each serviceand pass the appropriate
# command-line options
#export DMM7510_CURRENT_PV_AREA_PREFIX=DMM7510_${DMM7510_INSTANCE}_PV_AREA_PREFIX
#export DMM7510_CURRENT_PV_DEVICE_PREFIX=DMM7510_${DMM7510_INSTANCE}_PV_DEVICE_PREFIX
#export DMM7510_CURRENT_DEVICE_IP=DMM7510_${DMM7510_INSTANCE}_DEVICE_IP
#export EPICS_PV_AREA_PREFIX=${!DMM7510_CURRENT_PV_AREA_PREFIX}
#export EPICS_PV_DEVICE_PREFIX=${!DMM7510_CURRENT_PV_DEVICE_PREFIX}
#export EPICS_DEVICE_IP=${!DMM7510_CURRENT_DEVICE_IP}

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

IPADDR="$IPADDR" IPPORT="$IPPORT" P="$P" R="$R" RDMM="$RDMM" "$IOC_BIN" "$ST_CMD_FILE"
