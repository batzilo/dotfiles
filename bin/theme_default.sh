#!/bin/bash

set -e

# Set the xterm colors
xrdb $HOME/src/dotfiles/Xresources

# Set the bash colors
sed -i 's/^PS1=.*/PS1=$LUKE_SMITH_PROMPT/' $HOME/src/dotfiles/bashrc

# Set the vim colors
sed -i 's/^set background=.*/set background=dark/' $HOME/src/dotfiles/vimrc
sed -i 's/^colorscheme.*/colorscheme mustang/' $HOME/src/dotfiles/vimrc


# Does not work :(
# sed -i 's/"userTheme":"light"/"userTheme":"dark"/' $HOME/.config/Slack/storage/slack-settings
