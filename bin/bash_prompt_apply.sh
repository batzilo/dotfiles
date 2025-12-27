#!/usr/bin/env bash
#
# Set the bash prompt, based on the current theme.
#

function apply_theme_default {
	source bash_prompt_luke_smith.sh
}

function apply_theme_solarized_light {
	source bash_prompt_simple.sh
}

function apply_theme_solarized_dark {
	source bash_prompt_simple.sh
}

# Persist the current selected theme on disk so that
# all new terminal emulators and shells can read it.
THEME_FILE="$HOME/.theme"

theme="default"
[ -r "$THEME_FILE" ] && theme=$(< "$THEME_FILE")

case "$theme" in
	default)
		apply_theme_default
		;;
	slight)
		apply_theme_solarized_light
		;;
	sdark)
		apply_theme_solarized_dark
		;;
	*)
		apply_theme_default
		;;
esac
