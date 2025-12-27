#
# ~/.bashrc
#
# Executed by (non-login) bash shells.
#
# For consistency, use 4 spaces for indentation.
#

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	export TERM=xterm-256color
	;;
rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	export TERM=rxvt-unicode-256color
	;;
*)
	;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'
	#alias grep='grep --color=auto'
	#alias fgrep='fgrep --color=auto'
	#alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -al'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

#
# Section: Set the PATH environment variable.
#

# Add a directory to PATH, if it's not already added.
# https://superuser.com/questions/39751
pathadd() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		# Put the new directory at the beginning of PATH.
		PATH="$1${PATH:+":$PATH"}"
	fi
}

# Include "~/.bin" to PATH if it exists.
if [ -d "$HOME/.bin" ]; then
	pathadd "$HOME/.bin"
fi

# Set up the Python development environment.
pydev() {
	export PYENV_ROOT="$HOME/src/pyenv"

	# Grab pyenv and pyenv-virtualenv code, if needed.
	if [ ! -d "$PYENV_ROOT" ]; then
		git clone git@github.com:pyenv/pyenv.git "$PYENV_ROOT"
		pushd "$PYENV_ROOT"
		src/configure
		make -C src
		popd
		git clone git@github.com:pyenv/pyenv-virtualenv.git "$PYENV_ROOT"/plugins/pyenv-virtualenv
	fi

	pathadd "$PYENV_ROOT/bin"

	# Needed for pipx. Needs to be before the $(pyenv init -) command.
	pathadd "$HOME/.local/bin"

	if command -v pyenv 1>/dev/null 2>&1; then
		eval "$(pyenv init -)"

		# The following line may make bash a bit slow to load.
		# See https://github.com/pyenv/pyenv/issues/784.
		eval "$(pyenv virtualenv-init -)"
	fi

	# Needed for pipx autocomplete.
	eval "$(register-python-argcomplete pipx)"

	cat <<-EOH
		pydev: You are all set!
		pydev:
		pydev: Use 'pyenv install X.Y.Z' to install a specific Python version.
		pydev: Use 'pyenv virtualenv <version> <name>' to create a new virtual environment.
		pydev: Use 'pyenv local <name>' inside your project to set the local virtual environment.
	EOH
}

# Setup ghcup-env.
pathadd "$HOME/.cabal/bin"
pathadd "$HOME/.ghcup/bin"

#
# Section: Set the bash prompt (may depend on the theme).
#

source bash_prompt_apply.sh

#
# Section: Set up ssh agent.
#

# Start the ssh agent and add all (private) keys.
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
	mkdir -p ~/.ssh
	eval `ssh-agent`
	ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
	if [ -d ~/ssh_keys ];
	then
		# find ~/ssh_keys -type f -name id_rsa* | grep -v ".pub$" | xargs -I foo ssh-add foo
		for priv_key in `find ~/ssh_keys -type f -name id_rsa* | grep -v ".pub$" | grep -v "ppk"`;
		do
			ssh-add $priv_key
		done
	fi
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

#
# Section: Set up useful stuff.
#

# A helpful shortcut for pretty rewriting a branch history since develop.
alias grid='git rebase -i develop'

# Make less display the search result in the center rather than on top.
# export LESS=-j.5

# If the terminal emulator supports TrueColor, add transparency.
if [ -n "$COLORTERM" ]; then
	transset 0.95 --id "$WINDOWID" >/dev/null
fi

#
# Make bash start tmux by default when in SSH or GUI terminals.
#
# If $TERM is not "linux" (we are not running bash in a local TTY)
#   and
# if $STY is not set (we are not running bash inside screen)
#   and
# if $TMUX is not set (we are not running bash inside tmux)
#   then
# start a new tmux session.
#
if [ "$TERM" != "linux" -a -z "$STY" -a -z "$TMUX" ]; then
	tmux new
fi

# Set up SDKMAN.
export SDKMAN_DIR="$HOME/.sdkman"
export SDKMAN_INIT_SH="$SDKMAN_DIR/bin/sdkman-init.sh"
[[ -s "$SDKMAN_INIT_SH" ]] && source "$SDKMAN_INIT_SH"
