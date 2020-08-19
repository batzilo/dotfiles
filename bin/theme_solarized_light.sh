#!/bin/bash

set -e

# Set the xterm colors
xrdb $HOME/src/dotfiles/Xresources
xrdb -DSOLARIZED_LIGHT -merge $HOME/src/dotfiles/Xresources.solarized

# Set the bash colors
sed -i 's/^PS1=.*/PS1=$SIMPLE_PROMPT/' $HOME/src/dotfiles/bashrc

# Set the vim colors
sed -i 's/^set background=.*/set background=light/' $HOME/src/dotfiles/vimrc
sed -i 's/^colorscheme.*/colorscheme solarized/' $HOME/src/dotfiles/vimrc

# Does not work :(
# sed -i 's/"userTheme":"dark"/"userTheme":"light"/' $HOME/.config/Slack/storage/slack-settings
