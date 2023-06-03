#
# Set the bash prompt, based on the current theme.
#

THEME_FILE=~/.theme

function apply_theme_default {
	source luke_smith_prompt.sh
}

function apply_theme_solarized_light {
	source simple_prompt.sh
}

function apply_theme_solarized_dark {
	source simple_prompt.sh
}

theme="default"
[ -r $THEME_FILE ] && theme=$(< $THEME_FILE )

case $theme in
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
