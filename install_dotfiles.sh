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
DOTFILES="     \
	bashrc     \
	gitconfig  \
	profile    \
	screenrc   \
	vimrc      \
	Xresources \
	"

# Create a symbolic link for those files in $HOME, _if_ they exist.
MAYBE_DOTFILES="         \
	local.gitconfig      \
	arrikto.gitconfig    \
	blueground.gitconfig \
	"

# Create a symbolic link for those directories in $HOME.
DOTDIRS="  \
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

# Play it safe, approval wins force.
if [ "$ASK_FOR_APPROVAL" == "-i" ]; then
	USE_FORCE=""
fi

# Check if destination directory exists.
if [ ! -d $DST_DIR ]; then
	echo "/home/$TARGET_USER: No such directory exists"
	exit 1
fi

create_symblic_link () {
	SRC_DOTFILE=$SRC_DIR/$file
	DST_DOTFILE=$DST_DIR/.$file
	# If destination dotfile exists ...
	if [ -f $DST_DIR/.$file ]; then
		SRC_FILE_SHA=$(sha512sum $SRC_DOTFILE | awk '{print $1}')
		DST_FILE_SHA=$(sha512sum $DST_DOTFILE | awk '{print $1}')
		# ... and if contents are the same ...
		if [ "$SRC_FILE_SHA" == "$DST_FILE_SHA" ]; then
			# ... then skip.
			return
		fi
	fi
	echo "Creating a symbolic link for $DST_DOTFILE"
	ln -s $ASK_FOR_APPROVAL $USE_FORCE $SRC_DOTFILE $DST_DOTFILE
	chown -h $TARGET_USER:$TARGET_USER $DST_DOTFILE
}

# Create symbolic links for the dotfiles.
for file in $DOTFILES; do
	create_symblic_link
done
unset file

# Create symbolic links for the maybe_dotfiles, if any.
for file in $MAYBE_DOTFILES; do
	if [ -f $file ]; then
		create_symblic_link
	fi
done
unset file

# Create symbolic links for the dot_directories.
for dir in $DOTDIRS; do
	DST_DOTDIR=$DST_DIR/.$dir
	if [ -d $DST_DOTDIR ]; then
		# Directory already exists, skip.
		continue
	fi
	echo "Creating a symbolic link for $DST_DOTDIR"
	ln -s -T $ASK_FOR_APPROVAL $USE_FORCE $SRC_DIR/$dir $DST_DOTDIR
	chown -R $TARGET_USER:$TARGET_USER $DST_DOTDIR
done
unset dir

# Install the git submodules.
git submodule init
git submodule update

echo "Enjoy!"
