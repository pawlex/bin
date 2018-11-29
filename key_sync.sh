#!/bin/bash

#  Run at 45 minutes past every 12th hour.
#  45 */12 * * * ~/bin/key_sync.sh

USERNAME=pawlex
CURL=/usr/bin/curl
TARGET=~/.ssh/authorized_keys
TEMP=$TARGET.new

if [ ! -d ~/.ssh ]; then
  mkdir -p ~/.ssh
  chmod 700 ~/.ssh
fi

if [ -f $CURL ]; then
 $($CURL -s https://github.com/$USERNAME.keys -o $TEMP)
fi

if [ -s $TARGET.new ]; then
 mv -f $TEMP $TARGET
 chmod 600 $TARGET
fi

exit 0
