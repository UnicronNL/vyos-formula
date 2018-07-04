#!/bin/vbash
source /opt/vyatta/etc/functions/script-template
# enter configuration mode
configure

# load configuration from file
load config.boot

# commit and save
commit
save

# exit config
exit
