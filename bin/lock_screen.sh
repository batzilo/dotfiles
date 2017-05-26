#/bin/bash

# Install xscreensaver
# # apt-get install xscreensaver
#
# Configure
# # chmod +s /usr/bin/xscreensaver
#
# Start xscreensaver
# # xscreensaver -no-splash &
#
xscreensaver-command -activate 2>&1 > /dev/null
xscreensaver-command -lock 2>&1 > /dev/null
