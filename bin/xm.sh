#!/bin/bash

DISPLAY=:0 XINITRC=~/.xinitrc_xmonad xinit -- :0 vt7 -nolisten tcp &> ~/.xinitrc_xmonad.log
