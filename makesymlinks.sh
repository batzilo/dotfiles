#!/bin/bash
#
# makesymlinks.sh

set -e

DIR=~/git/dotfiles		# dotfiles directory
OLDDIR=~/git/dotfiles_old	# old dotfiles backup directory

# list of files/folders to symlink in homedir
FILES="\
	bashrc		\
	gitconfig	\
	profile		\
	screenrc	\
	vimrc		\
	xmonad		\
	zshrc		\
	"

# create dotfiles_old in homedir
echo -n "Creating $OLDDIR for backup of any existing dotfiles in ~ ... "
mkdir -p $OLDDIR
echo "done"

## change to the dotfiles directory
echo -n "Changing to the $DIR directory ... "
cd $DIR
echo "done"

# move any existing dotfiles in ~ to $OLDDIR directory,
# then create symlinks to ~ from any files in the $DIR directory
# as specified in $FILES
for file in $FILES; do
	if [ -f ~/.$file ]; then
		echo "Moving ~/.$file from ~ to $OLDDIR"
		mv ~/.$file $OLDDIR
	fi
	echo "Creating symlink of $DIR/$file to ~/.$file"
	ln -f -s $DIR/$file ~/.$file
done

# move vim directory
if [[ -d $DIR/vim ]]; then
	if [ -d ~/.vim ]; then
		echo "Moving ~/.vim from ~ to $OLDDIR"
		mv ~/.vim $OLDDIR
	fi
	echo "Creating symlink of $DIR/vim to ~/.vim"
	ln -f -s $DIR/vim ~/.vim
fi

# update oh-my-zsh
if [[ -d ~/git/oh-my-zsh ]]; then
	echo "Updating oh-my-zsh"
	cd ~/git/oh-my-zsh
	git pull
	cd -
fi

install_zsh () {
	# Test to see if zshell is installed.  If it is:
	if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
		# Clone my oh-my-zsh repository from GitHub
		# if it isn't already present
		if [[ ! -d ~/git/oh-my-zsh ]]; then
			git clone \
				http://github.com/robbyrussell/oh-my-zsh.git \
				~/git/oh-my-zsh
		fi
		# Set the default shell to zsh
		# if it isn't currently set to zsh
		if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
			chsh -s $(which zsh)
		fi
	else
		# If zsh isn't installed, tell the user to install zsh :)
		echo "Please install zsh, then re-run this script!"
	fi
}

install_zsh

echo
echo "Done!"
