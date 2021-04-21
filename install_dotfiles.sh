#!/bin/bash
#
# Install the dotfiles.
#
# Do not simply copy the files from this git repo to $HOME.
# If then the dotfiles are edited directly,
# the changes will not be tracked by git.
#
# Instead, use symbolic links.
#
# Usage:
# $ ./install_dotfiles.sh [-v] [-i] [-f]
#

set -e

# Create a symbolic link for those files in $HOME.
DOTFILES="\
	bashrc            \
	gitconfig         \
	profile	          \
	screenrc          \
	vimrc             \
	Xresources        \
	"

# Create a symbolic link for those files in $HOME, _if_ they exist.
MAYBE_DOTFILES="\
	local.gitconfig      \
	arrikto.gitconfig    \
	blueground.gitconfig \
	"

# Create a symbolic link for those directories in $HOME.
DOTDIRS="\
	bin    \
	fonts  \
	vim    \
	xmonad \
	"

: "${TARGET_USER:=$(whoami)}"
SRC_DIR="$(pwd)"
DST_DIR="/home/$TARGET_USER"
ASK_FOR_APPROVAL=""
USE_FORCE=""

while :
do
        case "$1" in
                "-v" | "--verbose")
                        # Be verbose.
                        set -x
                        ;;
		"-i" | "--interactive")
			# Stop and ask for approval.
			ASK_FOR_APPROVAL="-i"
			;;
		"-f" | "--force")
			# Use (the) force.
			USE_FORCE="-f"
			;;
                *)
                        ;;
        esac
        shift || break
done

# Check if destination directory exists.
if [ ! -d $DST_DIR ]; then
	echo "/home/$TARGET_USER: No such directory exists"
	exit 1
fi

# Create symbolic links for the dotfiles.
for file in $DOTFILES; do
	echo "Creating a symbolic link for $DST_DIR/.$file"
	ln -s $ASK_FOR_APPROVAL $USE_FORCE $SRC_DIR/$file $DST_DIR/.$file
	chown -h $TARGET_USER:$TARGET_USER $DST_DIR/.$file
done
unset file

# Create symbolic links for the maybe_dotfiles, if any.
for maybe_file in $MAYBE_DOTFILES; do
	if [ -f $maybe_file ]; then
		echo "Creating a symbolic link for $DST_DIR/.$maybe_file"
		ln -s $ASK_FOR_APPROVAL $USE_FORCE $SRC_DIR/$maybe_file $DST_DIR/.$maybe_file
		chown -h $TARGET_USER:$TARGET_USER $DST_DIR/.$maybe_file
	fi
done
unset maybe_file

# Create symbolic links for the dot_directories.
for dir in $DOTDIRS; do
	echo "Creating a symbolic link for $DST_DIR/.$dir"
	ln -s -T $ASK_FOR_APPROVAL $USE_FORCE $SRC_DIR/$dir $DST_DIR/.$dir
	chown -R $TARGET_USER:$TARGET_USER $DST_DIR/.$dir
done
unset dir

# Install black.
pip install black || pip3 install black

# Install the git submodules.
git submodule init
git submodule update

echo "Enjoy!"
