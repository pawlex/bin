#!/usr/bin/env bash

USERNAME=""
APIKEY=""
TUNNEL_ID=""

# Load configuration from file if it exists.
# You may also define your credendials inline (below)
BASE="$(dirname "$0")"

if [ -e $BASE/tunnelbroker.cf ]; then
    source $BASE/tunnelbroker.cf
fi


# Need to make sure the system has CURL installed.
if hash curl 2>/dev/null; then
    CURL=`which curl`
else
    printf "CURL not installed"
    exit -1
fi

URL="https://${USERNAME}:${APIKEY}@ipv4.tunnelbroker.net/nic/update?hostname=${TUNNEL_ID}"

RETVAL=$(eval $CURL -4 $URL)
echo $RETVAL

exit 0
