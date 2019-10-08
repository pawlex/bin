#!/bin/bash
###################################################################
#Script Name    : key_sync.sh
#Description    : Syncronize your private_keys with a hosted
#               : authorized_keys file.
#Args           : NONE
#Required Defs  : USERNAME
#Optional Defs  : GISTID
#Author         : Paul Komurka
#Email          : pawlex@gmail.com
###################################################################


# BASIC CRON EXAMPLE
# Run at 45 minutes past every 12th hour.
# 45 */12 * * * ~/bin/key_sync.sh

# Load configuration from file if it exists.
# You may also define your credendials inline (below)
BASE="$(dirname "$0")"

if [ -e $BASE/config.cf ]; then
    source $BASE/config.cf
fi

# GITHUB USERNAME (REQUIRED)
USERNAME=""

# Define to use private gist as opposed to github managed authorized_keys.
GISTID=""

# Not necessary to modify anything below this line.
CURL=/usr/bin/curl
TARGET=~/.ssh/authorized_keys
TEMP=$TARGET.new

# Abort if nececessary configuration is not defined.
if [ -z "$USERNAME" ]; then
        echo "USERNAME not defined"
        return -1
fi

# Determine which method to use, Private GIST or GITHUB's authorized_keys.
if [ -z "$GISTURL" ]; then
        URL="https://github.com/${USERNAME}.keys"
else
        URL="https://gist.githubusercontent.com/${USERNAME}/${GISTID}/raw/"
fi

if [ ! -d ~/.ssh ]; then
  mkdir -p ~/.ssh
  chmod 700 ~/.ssh
fi

# if CURL is installed
if [ -f $CURL ]; then
  # Grab SSH Keys from github
  $($CURL -s https://github.com/$USERNAME.keys -o $TEMP)
 else
  echo "key not updated.  curl is not installed"
  exit -1
fi

# If temp file exists and is not null
if [ -s $TEMP ]; then
 # Overwrite authorized_keys with that on github
 mv -f $TEMP $TARGET
 chmod 600 $TARGET
fi

exit 0
