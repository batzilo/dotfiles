#!/bin/bash
#
# Adjust the screen brightness for intel i915.
#
# Requirements:
#
# * NOTE: The following changes are done to sysfs, which means that they will
#         be undone by the next reboot. Consider using a udev rule to make
#         these changes persistent across reboots.
#
# * The user is a member of the "video" group.
#
#   ```
#   # groups $username
#   # adduser $username video
#   ```
#
# * The /sys/class/backlight/ directory contains a symlink to the actual device
#   sysfs directory.
#
#   ```
#   # ls -al /sys/class/backlight/
#   ```
#
# * The /sys/class/backlight/<vendor>/brightness and max_brightness files are
#   owned by the "video" group.
#
#   ```
#   # chgrp video /sys/class/backlight/<vendor>/brightness
#   # chgrp video /sys/class/backlight/<vendor>/max_brightness
#   ```
#
# * The /sys/class/backlight/<vendor>/brightness and max_brightness files are
#   writable by the "video" group.
#
#   ```
#   # chmod g+w /sys/class/backlight/<vendor>/brightness
#   # chmod g+w /sys/class/backlight/<vendor>/max_brightness
#   ```
#
# If the colors seem off, you can try:
#
# ```
# # xrandr --display X --gamma 1:1:1
# ```
#

# fail early and loudly
set -e

# The specific vendor
VENDOR="intel_backlight"

# The sysfs base directory
BASE="/sys/class/backlight/$VENDOR"

# The brightness file
BR_FILE="$BASE/brightness"

# Get the current brightness
CURR_BR=$(cat $BR_FILE)

# The max brightness file
MAX_BR_FILE="$BASE/max_brightness"

# Get the maximum brightness
MAX_BR=$(cat $MAX_BR_FILE)

# The number of steps
NR_STEPS=9

# The step value
STEP=$(( MAX_BR / NR_STEPS ))


while :
do
	case "$1" in
		"i" | "inc" | "increase")
			INCREASE=1
			NEW_BR=$(( $CURR_BR + $STEP ))
			if [[ $NEW_BR -gt $MAX_BR ]]; then
				NEW_BR=$MAX_BR
			fi
			echo $NEW_BR > $BR_FILE
			cat $BR_FILE
			break
			;;
		"d" | "dec" | "decrease")
			DECREASE=1
			NEW_BR=$(( $CURR_BR - $STEP ))
			if [[ $NEW_BR -lt 0 ]]; then
				NEW_BR=0
			fi
			echo $NEW_BR > $BR_FILE
			cat $BR_FILE
			break
			;;
		*)
			echo $CURR_BR
			;;
	esac
	shift || break
done
