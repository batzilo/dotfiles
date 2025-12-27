#!/usr/bin/env bash

# # A perl scrip to print four lines with color blocks:
# # normal 0-7, bold 0-7, normal 8-15, and bold 8-15
# perl -CADS -lwe '
# my $block = shift || (chr(0x2588) x 3);
# for (["", 0], ["1;", 0], ["", 8], ["1;", 8]) {
#   my ($bold, $offset) = @$_;
#   my @range = map $offset + $_, 0..7;
#   printf "%s %-6s ", $bold ? "bold" : "norm", "$range[0]-$range[-1]";
#   print map("\e[${bold}38;5;${_}m$block", @range), "\e[0m"
# }
# ' "$@"


# The following bash script uses the "\033[38;5;<number>m" sequence
# which use the ANSI 256 colors (8-bit).

# Unicode full block character
block="███"

echo "Standard colors"
for ((i = 0; i < 8; i++)); do
	printf "\e[38;5;%dm%s" "$i" "$block"
	if (( (i + 1) % 8 == 0 )); then
		printf "\e[0m\n"
	fi
done
printf "\e[0m\n" # reset

echo "High-intensity colors"
for ((i = 8; i < 16; i++)); do
	printf "\e[38;5;%dm%s" "$i" "$block"
	if (( (i - 8 + 1) % 8 == 0 )); then
		printf "\e[0m\n"
	fi
done
printf "\e[0m\n" # reset

echo "216 colors (6x6x6 cube)"
for ((i = 16; i < 232; i++)); do
	printf "\e[38;5;%dm%s" "$i" "$block"
	if (( (i - 16 + 1) % 24 == 0 )); then
		printf "\e[0m\n"
	fi
done
printf "\e[0m\n" # reset

echo "Grayscale colors (black to white in 24 steps)"
for ((i = 232; i < 256; i++)); do
	printf "\e[38;5;%dm%s" "$i" "$block"
	if (( (i - 232 + 1) % 12 == 0 )); then
		printf "\e[0m\n"
	fi
done
printf "\e[0m\n" # reset
