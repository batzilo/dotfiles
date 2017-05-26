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

# Configure pm-suspend
# give sudo no password to group 'powersuspend'
# add user to that group
sudo pm-suspend

#dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Suspend
