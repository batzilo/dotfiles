#!/bin/bash

xrdb        $HOME/src/dotfiles/Xresources

# xrdb -merge $HOME/src/dotfiles/Xresources/solarized.light

sed -i 's/^colorscheme.*/colorscheme mustang/' $HOME/src/dotfiles/vimrc

# Does not work :(
# sed -i 's/"userTheme":"light"/"userTheme":"dark"/' $HOME/.config/Slack/storage/slack-settings
