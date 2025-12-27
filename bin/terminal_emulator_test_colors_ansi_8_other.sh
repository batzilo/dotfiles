#!/usr/bin/env bash
#
# https://gist.github.com/sdeaton2/8450564
#
# This is slightly altered from the original which is found here:
# http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
#
# Each line is the color code of one foreground color, out of 17
# (default + 16 escapes), followed by a test use of that color
# on all nine background colors (default + 8 escapes).
#
# Everything here is classic ANSI SGR (Select Graphic Rendition).
# This is ANSI 16 colors (basic colors + high-intensity colors).
# Not 256-color, not TrueColor.
#
# 30m black
# 31m red
# 32m green
# 33m yellow
# 34m blue
# 35m magenta
# 36m cyan
# 37m white
#
# 40m black background
# 41m red background
# 42m green background
# 43m yellow background
# 44m blue background
# 45m magenta background
# 46m cyan background
# 47m white background
#
# The `1;` prefix means bold or bright or high-intensity.
#

text="xYz"; # Some test text

echo -e "\n                40m   41m   42m   43m   44m   45m   46m   47m";

for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
           '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
           '  36m' '1;36m' '  37m' '1;37m'; do
	   FG=${FGs// /}
	   echo -en " $FGs \033[$FG  ${text}  ";
	   for BG in 40m 41m 42m 43m 44m 45m 46m 47m; do
		   # What is `$EINS` here?
		   echo -en "$EINS \033[$FG\033[${BG} ${text} \033[0m";
	   done
	   echo;
done
echo;
