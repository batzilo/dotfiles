#!/usr/bin/env bash

# Run this shell script inside a terminal emulator.
# If it prints a smooth gradient, the terminal emulator supports TrueColor.
# If the output is banded, the terminal emulator does not support TrueColor.

awk 'BEGIN{
for(i=0;i<77;i++){
    r=int(255*i/76);
    g=int(255*(76-i)/76);
    b=128;
    printf "\033[48;2;%d;%d;%dm ",r,g,b;
}
print "\033[0m"
}'

echo

# The following code echoes a bunch of 24-bit color codes
# to the terminal to demonstrate its functionality.
# The foreground escape sequence is ^[38;2;<r>;<g>;<b>m
# The background escape sequence is ^[48;2;<r>;<g>;<b>m
# <r> <g> <b> range from 0 to 255 inclusive.
# The escape sequence ^[0m returns output to default

setBackgroundColor()
{
    echo -en "\x1b[48;2;$1;$2;$3""m"
}

resetOutput()
{
    echo -en "\x1b[0m\n"
}

# Gives a color $1/255 % along HSV
# Who knows what happens when $1 is outside 0-255
# Echoes "$red $green $blue" where
# $red $green and $blue are integers
# ranging between 0 and 255 inclusive
rainbowColor()
{ 
    let h=$1/43
    let f=$1-43*$h
    let t=$f*255/43
    let q=255-t

    if [ $h -eq 0 ]
    then
        echo "255 $t 0"
    elif [ $h -eq 1 ]
    then
        echo "$q 255 0"
    elif [ $h -eq 2 ]
    then
        echo "0 255 $t"
    elif [ $h -eq 3 ]
    then
        echo "0 $q 255"
    elif [ $h -eq 4 ]
    then
        echo "$t 0 255"
    elif [ $h -eq 5 ]
    then
        echo "255 0 $q"
    else
        # execution should never reach here
        echo "0 0 0"
    fi
}

for i in `seq 0 127`; do
    setBackgroundColor $i 0 0
    echo -en " "
done
resetOutput
for i in `seq 255 128`; do
    setBackgroundColor $i 0 0
    echo -en " "
done
resetOutput

for i in `seq 0 127`; do
    setBackgroundColor 0 $i 0
    echo -n " "
done
resetOutput
for i in `seq 255 128`; do
    setBackgroundColor 0 $i 0
    echo -n " "
done
resetOutput

for i in `seq 0 127`; do
    setBackgroundColor 0 0 $i
    echo -n " "
done
resetOutput
for i in `seq 255 128`; do
    setBackgroundColor 0 0 $i
    echo -n " "
done
resetOutput

for i in `seq 0 127`; do
    setBackgroundColor `rainbowColor $i`
    echo -n " "
done
resetOutput
for i in `seq 255 128`; do
    setBackgroundColor `rainbowColor $i`
    echo -n " "
done
resetOutput


# Notes:
#
# bash on xterm
# shows a smooth gradient
# $ echo "$TERM"
# xterm-256color
# $ echo "$COLORTERM"
# (nothing)
# $ xterm -version
# XTerm(397)
#
# bash on tmux on xterm
# shows a smooth gradient
# $ echo "$TERM"
# tmux-256color
# $ echo "$COLORTERM"
# truecolor
# $ tmux -V
# tmux 3.5a
# $ xterm -version
# XTerm(397)
#
# bash on urxvt
# shows a banded output
# $ echo "$TERM"
# rxvt-unicode-256color
# $ echo "$COLORTERM"
# rxvt-xpm
# $ urxvt --help
# rxvt-unicode (urxvt) v9.31 - released: 2023-01-02
#
# bash on tmux on urxvt
# shows a banded output
# $ echo "$TERM"
# tmux-256color
# $ echo "$COLORTERM"
# truecolor
# $ urxvt --help
# rxvt-unicode (urxvt) v9.31 - released: 2023-01-02
#
# bash on Mate Terminal
# shows a smooth gradient
# $ echo "$TERM"
# xterm-256color
# $ echo "$COLORTERM"
# truecolor
# $ mate-terminal --version
# MATE Terminal 1.26.1
#
# bash on tmux on Mate Terminal
# shows a smooth gradient
# $ echo "$TERM"
# tmux-256color
# $ echo "$COLORTERM"
# truecolor
# $ mate-terminal --version
# MATE Terminal 1.26.1
#
