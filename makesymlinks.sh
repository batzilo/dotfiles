#!/bin/bash
#
# .makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
#

set -e

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="bashrc \
	gitconfig \
	profile \
	screenrc \
	vimrc \
	xmonad \
	zshrc"


# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ... "
mkdir -p $olddir
echo "done"

## change to the dotfiles directory
#echo -n "Changing to the $dir directory ... "
#cd $dir
#echo "done"

# move any existing dotfiles in homedir to olddir directory,
# then create symlinks to homedir from any files in the ~/dotfiles directory specified in $files
for file in $files; do
	if [ -f ~/.$file ]; then
		echo "Moving ~/.$file from ~ to $olddir"
		mv ~/.$file ~/dotfiles_old/
	fi
	echo "Creating symlink to $file in home directory."
	ln -f -s $dir/$file ~/.$file
done

if [[ -d $dir/vim ]]; then
	if [[ -d ~/.vim ]]; then
		echo "Moving ~/.vim from ~ to $olddir"
		mv ~/.vim ~/dotfiles_old/
	fi
	echo "Creating symlink to vim in home directory."
	ln -s $dir/vim ~/.vim
fi

if [[ -d ~/oh-my-zsh ]]; then
	echo "Update oh-my-zsh"
	cd ~/oh-my-zsh
	git pull
	cd -
fi

exit

install_zsh () {
	# Test to see if zshell is installed.  If it is:
	if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
		# Clone my oh-my-zsh repository from GitHub only if it isn't already present
		if [[ ! -d $dir/oh-my-zsh/ ]]; then
			git clone http://github.com/robbyrussell/oh-my-zsh.git
		fi
		# Set the default shell to zsh if it isn't currently set to zsh
		if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
			chsh -s $(which zsh)
		fi
	else
		# If zsh isn't installed, tell the user to install zsh :)
		echo "Please install zsh, then re-run this script!"
		exit
	fi
}

install_zsh
