#!/bin/sh

: ${EPICS_HOST_ARCH:?"Environment variable needs to be set"}

# Select endpoint.
DEVICE_IP=$1

if [ -z "$DEVICE_IP" ]; then
    echo "\"DEVICE_IP\" variable unset."
    exit 1
fi

DEVICE_IP=${DEVICE_IP} ../../bin/${EPICS_HOST_ARCH}/dmm7510 stDCCT.cmd
