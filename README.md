# key_sync
#### automates management of ssh authorized_keys file
* pulls authorized_keys from github/username/authorized_keys or private gist
* can be used with cron
* credentials can be defined in private config file or inline
* examples provided

# tunnelbroker_update
#### automates the update of HE tunnelbroker endpoint ipv4 address
* intended to be used with cron
* conditional update, using ipv6 connectivity as a signal
* will update tunnelbroker endpoint (b endpoint) with public IP address
* lightweight using curl
* inline and file-based configuration with example.
