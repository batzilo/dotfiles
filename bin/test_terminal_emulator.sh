# https://askubuntu.com/a/985386

TEXT="Lorem ipsum dolor sit amet"
END="\e[m"
END2="\e[0m"

echo -e "Normal: $TEXT"

echo -e "Bold: \e[1m$TEXT\e[22m" "$END"
echo -e "Dim: \e[2m$TEXT\e[22m" "$END"
echo -e "Italic: \e[3m$TEXT\e[23m" "$END"
echo -e "Underline: \e[4m$TEXT\e[24m" "$END"
echo -e "Also underline: \e[4:1m$TEXT\e[4:0m" "$END"
echo -e "Double underline: \e[21m$TEXT\e[24m" "$END"
echo -e "Also double underline: \e[4:2m$TEXT\e[4:0m" "$END"
echo -e "Curly underline: \e[4:3m$TEXT\e[4:0m" "$END"
echo -e "Blink: \e[5m$TEXT\e[25m" "$END"
echo -e "Reverse: \e[7m$TEXT\e[27m" "$END"
echo -e "Invisible (but copy-pastable): \e[8m$TEXT\e[28m" "$END"
echo -e "Strikethrough: \e[9m$TEXT\e[29m" "$END"
echo -e "Overline: \e[53m$TEXT\e[55m" "$END"

echo

echo -e "red: \e[31m$TEXT\e[39m" "$END"
echo -e "bright red: \e[91m$TEXT\e[39m" "$END"
echo -e "256-color, de jure standard (ITU-T T.416): \e[38:5:42m$TEXT\e[39m" "$END"
echo -e "256-color, de facto standard (commonly used): \e[38;5;42m$TEXT\e[39m" "$END"
echo -e "truecolor, de jure standard (ITU-T T.416) (new in 0.52): \e[38:2::240:143:104m$TEXT\e[39m" "$END"
echo -e "truecolor, rarely used incorrect format (might be removed at some point): \e[38:2:240:143:104m$TEXT\e[39m" "$END"
echo -e "truecolor, de facto standard (commonly used): \e[38;2;240;143;104m$TEXT\e[39m" "$END"

echo

echo -e "cyan background: \e[46m$TEXT\e[49m" "$END"
echo -e "bright cyan background: \e[106m$TEXT\e[49m" "$END"
echo -e "256-color background, de jure standard (ITU-T T.416): \e[48:5:42m$TEXT\e[49m" "$END"
echo -e "256-color background, de facto standard (commonly used): \e[48;5;42m$TEXT\e[49m" "$END"
echo -e "truecolor background, de jure standard (ITU-T T.416) (new in 0.52): \e[48:2::240:143:104m$TEXT\e[49m" "$END"
echo -e "truecolor background, rarely used incorrect format (might be removed at some point): \e[48:2:240:143:104m$TEXT\e[49m" "$END"
echo -e "truecolor background, de facto standard (commonly used): \e[48;2;240;143;104m$TEXT\e[49m" "$END"

echo

echo -e "256-color underline (new in 0.52): \e[21m\e[58:5:42m$TEXT\e[59m\e[24m" "$END"
echo -e "256-color underline (new in 0.52): \e[21m\e[58;5;42m$TEXT\e[59m\e[24m" "$END"
echo -e "truecolor underline (new in 0.52): \e[4:3m\e[58:2::240:143:104m$TEXT\e[59m\e[4:0m" "$END"
echo -e "truecolor underline (new in 0.52) (might be removed at some point): \e[4:3m\e[58:2:240:143:104m$TEXT\e[59m\e[4:0m" "$END"
echo -e "truecolor underline (new in 0.52): \e[4:3m\e[58;2;240;143;104m$TEXT\e[59m\e[4:0m" "$END"

echo

echo -e "hyperlink: \e]8;;http://askubuntu.com\e\\hyperlink\e]8;;\e\\"
