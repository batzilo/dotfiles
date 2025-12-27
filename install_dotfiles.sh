#!/usr/bin/env bash
#
# Install the dotfiles using symbolic links.
#
# Do not simply copy the files from this git repo to $HOME.
# If then the dotfiles are edited directly,
# the changes will not be tracked by git.
# Instead, use symbolic links.
#
# Usage:
# $ ./install_dotfiles.sh [-v] [-i] [-f]
# Make sure you run this script from within this git repo.
#

# fail early and loudly
set -e

# Create a symbolic link for those files in $HOME.
DOTFILES="         \
	bashrc     \
	gitconfig  \
	picom.conf \
	profile    \
	screenrc   \
	tmux.conf  \
	vimrc      \
	zathurarc  \
	"

# NOTE: You probably want to create the following symbolic link:
# $ ln -s -i "$HOME/.zathurarc" "$HOME/zathurarc"

# Moved from above to here for future reference.
UNUSED_DOTFILES="  \
	Xresources \
	"

# Create a symbolic link for those files in $HOME, _if_ they exist.
MAYBE_DOTFILES="             \
	local.gitconfig      \
	arrikto.gitconfig    \
	blueground.gitconfig \
	"

# Create a symbolic link for those directories in $HOME.
DOTDIRS="      \
	bin    \
	fonts  \
	vim    \
	xmonad \
	"

: "${TARGET_USER:=$(whoami)}"
SRC_DIR="$(pwd)"
DST_DIR="/home/$TARGET_USER"

while :
do
	case "$1" in
		"-v" | "--verbose")
			# Be verbose.
			set -x
			;;
		*)
			;;
	esac
	shift || break
done

# Check if the destination directory exists.
if [ ! -d "$DST_DIR" ]; then
	echo "$DST_DIR: No such directory exists"
	exit 1
fi

create_symblic_link_for_file () {
	local file="$1"
	SRC_DOTFILE="$SRC_DIR/$file"
	DST_DOTFILE="$DST_DIR/.$file"
	# If the source dotfile does not exist, skip.
	# This may catch issues if running this script from the wrong directory.
	if [ ! -f "$SRC_DOTFILE" ]; then
		echo "$SRC_DOTFILE: No such file or directory. Are you running the install_dotfiles.sh script from within the dotfiles directory?"
		return
	fi
	if [ -f "$DST_DOTFILE" ]; then
		SRC_FILE_SHA=$(sha512sum "$SRC_DOTFILE" | awk '{print $1}')
		DST_FILE_SHA=$(sha512sum "$DST_DOTFILE" | awk '{print $1}')
		# ... and if it has same contents as source dotfile ...
		if [ "$SRC_FILE_SHA" == "$DST_FILE_SHA" ]; then
			# ... then skip.
			echo "$DST_DOTFILE: already matches $SRC_DOTFILE, nothing to do, skipping."
			return
		fi
	fi
	echo "Creating a symbolic link for $DST_DOTFILE"
	ln -s -i "$SRC_DOTFILE" "$DST_DOTFILE" || echo "Failed to create a symbolic link for $DST_DOTFILE"
	# Change the ownership of the symbolic link.
	chown -h "$TARGET_USER:$TARGET_USER" "$DST_DOTFILE"
}

create_symblic_link_for_dir () {
	local dir="$1"
	SRC_DOTDIR="$SRC_DIR/$dir"
	DST_DOTDIR="$DST_DIR/.$dir"
	# If the source dotdir does not exist, skip.
	# This may catch issues if running this script from the wrong directory.
	if [ ! -d "$SRC_DOTDIR" ]; then
		echo "$SRC_DOTDIR: No such file or directory. Are you running the install_dotfiles.sh script from within the dotfiles directory?"
		return
	fi
	if [ -d "$DST_DOTDIR" ]; then
		# Directory already exists, skip.
		echo "$DST_DOTDIR: already exists, skipping."
		return
	fi
	echo "Creating a symbolic link for $DST_DOTDIR"
	ln -s -T -i "$SRC_DOTDIR" "$DST_DOTDIR" || echo "Failed to create a symbolic link for $DST_DOTDIR"
	# Change the ownership of the symbolic link.
	chown -R "$TARGET_USER:$TARGET_USER" "$DST_DOTDIR"
}

# Create symbolic links for the dotfiles.
for file in $DOTFILES; do
	create_symblic_link_for_file "$file"
done

# Create symbolic links for the maybe_dotfiles, if any.
for file in $MAYBE_DOTFILES; do
	if [ -f "$file" ]; then
		create_symblic_link_for_file "$file"
	fi
done

# Create symbolic links for the dot_directories.
for dir in $DOTDIRS; do
	create_symblic_link_for_dir "$dir"
done

if [ -d ".git" ]; then
	# Install the git submodules in this git repo.
	git submodule init
	git submodule update
fi

echo "Enjoy!"
