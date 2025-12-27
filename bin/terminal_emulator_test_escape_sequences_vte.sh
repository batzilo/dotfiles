#!/usr/bin/env bash

# https://askubuntu.com/a/528938

echo "Here are the most common control sequences for formatting text:"

echo -e "normal text, \e[1mBold text\e[0m"
echo -e "normal text, \e[2mDim text\e[0m"
echo -e "normal text, \e[3mitalic text\e[0m"
echo -e "normal text, \e[4mUnderlined text\e[0m"
echo -e "normal text, \e[5mBlink text\e[0m"
echo -e "normal text, \e[7minverted text\e[0m"
echo -e "normal text, \e[8mHidden Text\e[0m (hidden text, still copy-able)"
echo -e "normal text, \e[9mstrikethrough text\e[0m"
echo

# https://askubuntu.com/a/985386

echo "Here are some VTE additions to the standard escape sequences:"

echo -e 'normal text, \e[1mbold\e[22m'
echo -e 'normal text, \e[2mdim\e[22m'
echo -e 'normal text, \e[3mitalic\e[23m'
echo -e 'normal text, \e[4munderline\e[24m'
echo -e 'normal text, \e[4:1mthis is also underline (since 0.52)\e[4:0m'
echo -e 'normal text, \e[21mdouble underline (since 0.52)\e[24m'
echo -e 'normal text, \e[4:2mthis is also double underline (since 0.52)\e[4:0m'
echo -e 'normal text, \e[4:3mcurly underline (since 0.52)\e[4:0m'
echo -e 'normal text, \e[4:4mdotted underline (since 0.76)\e[4:0m'
echo -e 'normal text, \e[4:5mdashed underline (since 0.76)\e[4:0m'
echo -e 'normal text, \e[5mblink (since 0.52)\e[25m'
echo -e 'normal text, \e[7mreverse\e[27m'
echo -e 'normal text, \e[8minvisible\e[28m <- invisible (but copy-pasteable)'
echo -e 'normal text, \e[9mstrikethrough\e[29m'
echo -e 'normal text, \e[53moverline (since 0.52)\e[55m'

echo -e 'normal text, \e[31mred\e[39m'
echo -e 'normal text, \e[91mbright red\e[39m'
echo -e 'normal text, \e[38:5:42m256-color, de jure standard (ITU-T T.416)\e[39m'
echo -e 'normal text, \e[38;5;42m256-color, de facto standard (commonly used)\e[39m'
echo -e 'normal text, \e[38:2::240:143:104mtruecolor, de jure standard (ITU-T T.416) (since 0.52)\e[39m'
echo -e 'normal text, \e[38:2:240:143:104mtruecolor, rarely used incorrect format (might be removed at some point)\e[39m'
echo -e 'normal text, \e[38;2;240;143;104mtruecolor, de facto standard (commonly used)\e[39m'

echo -e 'normal text, \e[46mcyan background\e[49m'
echo -e 'normal text, \e[106mbright cyan background\e[49m'
echo -e 'normal text, \e[48:5:42m256-color background, de jure standard (ITU-T T.416)\e[49m'
echo -e 'normal text, \e[48;5;42m256-color background, de facto standard (commonly used)\e[49m'
echo -e 'normal text, \e[48:2::240:143:104mtruecolor background, de jure standard (ITU-T T.416) (since 0.52)\e[49m'
echo -e 'normal text, \e[48:2:240:143:104mtruecolor background, rarely used incorrect format (might be removed at some point)\e[49m'
echo -e 'normal text, \e[48;2;240;143;104mtruecolor background, de facto standard (commonly used)\e[49m'

echo -e 'normal text, \e[21m\e[58:5:42m256-color underline (since 0.52)\e[59m\e[24m'
echo -e 'normal text, \e[21m\e[58;5;42m256-color underline (since 0.52)\e[59m\e[24m'
echo -e 'normal text, \e[4:3m\e[58:2::240:143:104mtruecolor underline (since 0.52) (*)\e[59m\e[4:0m'
echo -e 'normal text, \e[4:3m\e[58:2:240:143:104mtruecolor underline (since 0.52) (might be removed at some point) (*)\e[59m\e[4:0m'
echo -e 'normal text, \e[4:3m\e[58;2;240;143;104mtruecolor underline (since 0.52) (*)\e[59m\e[4:0m'

echo

echo -e 'hyperlink: \e]8;;http://askubuntu.com\e\\hyperlink\e]8;;\e\\'

echo -e 'another hyperlink: https://en.wikipedia.org/wiki/Central_processing_unit'

echo -e '\e[0m'

# Notes:
#
# xterm (no tmux)
# most seem to work, but not the fancy underlines
# not the hyperlink
#
# xterm with tmux
# most seem to work, but not the fancy underlines
# not the hyperlink
#
# urxvt (no tmux)
# most seem to work, but inverted, hidden, blink, strike through do not work and
# most underlines do not work
# not the hyperlink
#
# urxvt with tmux
# most seem to work, but not the fancy underlines
# not the hyperlink
#
# mate-terminal (no tmux)
# all seem to work
# not the hyperlink
#
# mate-terminal with tmux
# most seem to work, but not the fancy underlines
# not the hyperlink
#
