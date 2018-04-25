#!/bin/sh

set -e 

usage () {
    echo "Usage:" >&2
    echo "  $1 -t PROCSERV_TELNET_PORT [-P P_VAL] [-R R_VAL] -i IPADDR -p IPPORT -d DEVICE " >&2
    echo >&2
    echo " Options:" >&2
    echo "  -t                  Configure procServ telnet port" >&2
    echo "  -P                  Configure value of \$(P) macro" >&2
    echo "  -R                  Configure value of \$(R) macro" >&2
    echo "  -i                  Configure IP address to connect to device" >&2
    echo "  -p                  Configure IP port number to connect to device" >&2
    echo "  -d                  Configure DMM device type [DCCT|ICT|DMM]" >&2
}

while getopts ":t:P:R:i:p:d:" opt; do
  case $opt in
    t) DEVICE_TELNET_PORT="$OPTARG" ;;
    P) P="$OPTARG" ;;
    R) R="$OPTARG" ;;
    i) IPADDR="$OPTARG" ;;
    p) IPPORT="$OPTARG" ;;
    d) DEVICE_TYPE="$OPTARG" ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage $0
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      usage $0
      exit 1
      ;;
  esac
done
