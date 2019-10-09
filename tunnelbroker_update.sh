#!/usr/bin/env bash

# Load configuration from file if it exists.
# You may also define your credendials inline (below)
BASE="$(dirname "$0")"

if [ -e $BASE/tunnelbroker.cf ]; then
    source $BASE/tunnelbroker.cf
fi

#USERNAME=""
#APIKEY=""
#TUNNEL_ID=""
#P2P_LOCAL=""
#P2P_REMOTE=""


# Need to make sure the system has ping6 installed.
if hash ping6 2>/dev/null; then
    PING6=`which ping6` 
else
    printf "ping6 not installed"
    exit -1
fi

# Abort if local side of the tunnel isn't configured.
RETVAL=$(eval $PING6 -c 1 -X 1 ${P2P_LOCAL})

if [ $? != 0 ]; then 
	echo "Local side of the tunnel is not configured.  exiting"
	exit -1
fi

# Next, check to see if we can ping the remote side of the Tunnel.
# If so, then there is no need to update and we should exit.

RETVAL=$(eval $PING6 -c 1 -X 1 ${P2P_REMOTE})
if [ $? == 0 ]; then
	echo "IPv6 functional.  No update necessary.  exiting"
	exit 0
fi

# Need to make sure the system has CURL installed.
if hash curl 2>/dev/null; then
    CURL=`which curl`
else
    printf "CURL not installed"
    exit -1
fi

URL="https://${USERNAME}:${APIKEY}@ipv4.tunnelbroker.net/nic/update?hostname=${TUNNEL_ID}"

RETVAL=$(eval $CURL -4 $URL -s)
echo $RETVAL

exit 0
