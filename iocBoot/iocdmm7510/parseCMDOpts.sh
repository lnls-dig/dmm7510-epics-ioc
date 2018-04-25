#!/bin/sh

usage () {
    echo "Usage:" >&2
    echo "  $1 -i IPADDR -p IPPORT -d DEVICE [-P P_VAL] [-R R_VAL] " >&2
    echo >&2
    echo " Options:" >&2
    echo "  -i or --ip-addr     Configure IP address to connect to device" >&2
    echo "  -p or --ip-port     Configure IP port number to connect to device" >&2
    echo "  -d or --device      Configure DMM device type [DCCT<number>|ICT<number>|DMM<number>]" >&2
    echo "  -P                  Configure value of \$(P) macro" >&2
    echo "  -R                  Configure value of \$(R) macro" >&2
}

while getopts ":i:p:d:P:R:" opt; do
  case $opt in
    t) DMM7510_DEVICE_TELNET_PORT="$OPTARG" ;;
    P) P="$OPTARG" ;;
    R) R="$OPTARG" ;;
    i) IPADDR="$OPTARG" ;;
    p) IPPORT="$OPTARG" ;;
    d) DEVICE="$OPTARG" ;;
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
