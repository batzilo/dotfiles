#!/bin/bash
#
# Install dotfiles to home directory
#
# XXX: This script is destructive and irreversible

set -e

while :
do
        case "$1" in
                "-v" | "--verbose")
                        # be verbose
                        set -x
                        ;;
                *)
                        ;;
        esac
        shift || break
done

: "${TARGET_USER:=batzilo}"

: "${SRC_DIR:=/home/$TARGET_USER/src/dotfiles}"

: "${DST_DIR:=/home/$TARGET_USER}"


if [ ! -d /home/$TARGET_USER ];
then
	echo "/home/$TARGET_USER : No such directory"
	exit 1
fi

if [ ! -d $SRC_DIR ];
then
	echo "$SRC_DIR : No such directory"
	exit 1
fi

if [ ! -d $DST_DIR ];
then
	echo "$DST_DIR : No such directory"
	exit 1
fi


DOTFILES="\
	bashrc            \
	gitconfig         \
	profile	          \
	screenrc          \
	vimrc             \
	Xresources        \
	"

MAYBE_DOTFILES="\
	local.gitconfig   \
	arrikto.gitconfig \
	"

DOTDIRS="\
	bin    \
	vim    \
	xmonad \
	"

for file in $DOTFILES; do
	echo "Creating a symbolic link of '$SRC_DIR/$file' to '$DST_DIR/.$file'"
	ln -f -s $SRC_DIR/$file $DST_DIR/.$file
	chown -h $TARGET_USER:$TARGET_USER $DST_DIR/.$file
done
unset file

for maybe_file in $MAYBE_DOTFILES; do
	if [ -f "$SRC_DIR/$maybe_file" ];
	then
		echo "Creating a symbolic link of '$SRC_DIR/$maybe_file' to '$DST_DIR/.$maybe_file'"
		ln -f -s $SRC_DIR/$maybe_file $DST_DIR/.$maybe_file
		chown -h $TARGET_USER:$TARGET_USER $DST_DIR/.$maybe_file
	else
		echo "Could not find '$SRC_DIR/$maybe_file', continuing..."
	fi
done
unset maybe_file

for dir in $DOTDIRS; do
	echo "Creating a symbolic link of '$SRC_DIR/$dir' to '$DST_DIR/.$dir'"
	ln -f -s -T $SRC_DIR/$dir $DST_DIR/.$dir
	chown -R $TARGET_USER:$TARGET_USER $DST_DIR/.$dir
done
unset dir

echo "Enjoy!"
