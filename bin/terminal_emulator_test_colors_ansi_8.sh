#/usr/bin/env bash

# The following escape sequences are the original ANSI 8 colors (palette)
# plus the bright (high-intensity) variants (+ 8 colors).

function print_colored_text() {
	local setcode="$1"
	local text="$2"
	local resetcode="$3"
	local begin="\033[${setcode}m"
	local end="\033[${resetcode}m"
	echo -e "${begin}${text}${end}"
}

function black() {
	local text="$1"
	print_colored_text "30" "$text" "39"
}

function red() {
	local text="$1"
	print_colored_text "31" "$text" "39"
}

function green() {
	local text="$1"
	print_colored_text "32" "$text" "39"
}

function yellow() {
	local text="$1"
	print_colored_text "33" "$text" "39"
}

function blue() {
	local text="$1"
	print_colored_text "34" "$text" "39"
}

function magenta() {
	local text="$1"
	print_colored_text "35" "$text" "39"
}

function cyan() {
	local text="$1"
	print_colored_text "36" "$text" "39"
}

function white() {
	local text="$1"
	print_colored_text "37" "$text" "39"
}

function bright_black() {
	local text="$1"
	print_colored_text "90" "$text" "39"
}

function bright_red() {
	local text="$1"
	print_colored_text "91" "$text" "39"
}

function bright_green() {
	local text="$1"
	print_colored_text "92" "$text" "39"
}

function bright_yellow() {
	local text="$1"
	print_colored_text "93" "$text" "39"
}

function bright_blue() {
	local text="$2"
	print_colored_text "94" "$text" "39"
}

function bright_magenta() {
	local text="$1"
	print_colored_text "95" "$text" "39"
}

function bright_cyan() {
	local text="$1"
	print_colored_text "96" "$text" "39"
}

function bright_white() {
	local text="$1"
	print_colored_text "97" "$text" "39"
}

black "black"
red "red"
green "green"
yellow "yellow"
blue "blue"
magenta "magenta"
cyan "cyan"
white "white"
bright_black "bright_black"
bright_red "bright_red"
bright_green "bright_green"
bright_yellow "bright_yellow"
bright_blue "bright_blue"
bright_magenta "bright_magenta"
bright_cyan "bright_cyan"
bright_white "bright_white"
