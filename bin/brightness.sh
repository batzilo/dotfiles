#!/bin/bash
#
# Adjust the screen brightness for intel i915
#
# Make sure:
# * the current user is a member of "video" group
# * /sys/class/backlight/ is a symlink to the actual device sysfs directory
# * /sys/class/backlight/<vendor>/brightness file is in group "video"
#   # chgrp -R video /sys/class/backlight/<vendor>/
# * /sys/class/backlight/<vendor>/brightness file is writable by group
#   # chmod 664 /sys/class/backlight/<vendor>/brightness
# * /sys/class/backlight/<vendor>/max_brightness file is writable by group
#   # chmod 664 /sys/class/backlight/<vendor>/max_brightness
#
# If the colors seem off, try:
# # xrandr --display X --gamma 1:1:1
#

# fail early and loudly
set -e

# The specific vendor
VENDOR="intel_backlight"

# The sysfs base directory
BASE="/sys/class/backlight/$VENDOR/"

# The brightness file
BR_FILE="$BASE/brightness"

# Get the current brightness
CURR_BR=$(cat $BR_FILE)

# The max brightness file
MAX_BR_FILE="$BASE/max_brightness"

# Get the maximum brightness
MAX_BR=$(cat $MAX_BR_FILE)

# Get the step value
STEP=$(( 15 * MAX_BR / 100 ))


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
			;;
	esac
	shift || break
done
