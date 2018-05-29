#!/bin/bash
#
# Install dotfiles to home directory
# XXX: Destructive and irreversible

set -e

DIR=~/src/dotfiles

DOTFILES="\
	bashrc		\
	gitconfig	\
	profile		\
	screenrc	\
	vimrc		\
	Xresources	\
	"

DOTDIRS="\
	bin	\
	vim	\
	xmonad	\
	"

for file in $DOTFILES; do
	echo "Creating a symbolic link of '$DIR/$file' to '~/.$file'"
	ln -f -s $DIR/$file ~/.$file
done

for dir in $DOTDIRS; do
	echo "Creating a symbolic link of '$DIR/$dir' to '~/.$dir'"
	ln -f -s -T $DIR/$dir ~/.$dir
done

echo "Enjoy!"
