#
# ~/.profile
#
# Executed by login shells.
#

export EDITOR=vim

# Bash doesn't read ~/.bashrc in login shells, so source it manually.
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
