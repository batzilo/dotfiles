function pcc_start {
	picom --config $HOME/.picom.conf &
}

function pcc_is_running {
	pgrep picom > /dev/null
}

function pcc_kill {
	killall picom
}
