#!/bin/bash

xrdb        $HOME/src/dotfiles/Xresources

xrdb -merge $HOME/src/dotfiles/Xresources.solarized.light

sed -i 's/^colorscheme.*/colorscheme solarized/' $HOME/src/dotfiles/vimrc
