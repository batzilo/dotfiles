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
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    export TERM=xterm-256color
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

# Set up SDKMAN.
# Commented out, I don't use SDKMAN anymore.
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Support virtualenvwrapper.
# Commented out, use pyenv instead.
# export WORKON_HOME=~/.venvs
# source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

# Setup pyenv.
export PYENV_ROOT="$HOME/src/pyenv"
pathadd "$PYENV_ROOT/bin"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    # The following line makes bash slow!
    # See https://github.com/pyenv/pyenv/issues/784
    # eval "$(pyenv virtualenv-init -)"
fi

# Setup ghcup-env.
pathadd "$HOME/.cabal/bin"
pathadd "$HOME/.ghcup/bin"

#
# Section: Set the bash prompt.
#

# A simple bash prompt, broken up into pieces.
# The chroot thingy
SIMPLE_PROMPT='${debian_chroot:+($debian_chroot)}'
# Start with the green color
SIMPLE_PROMPT=$SIMPLE_PROMPT'\[\033[01;32m\]'
# An actual [
SIMPLE_PROMPT=$SIMPLE_PROMPT'\[\033[01;32m\][ '
# The username
SIMPLE_PROMPT=$SIMPLE_PROMPT'\[\033[01;32m\]\u '
# An actual @
SIMPLE_PROMPT=$SIMPLE_PROMPT'\[\033[01;34m\]@ '
# A hostname
SIMPLE_PROMPT=$SIMPLE_PROMPT'\[\033[01;32m\]\h '
# A blue path
SIMPLE_PROMPT=$SIMPLE_PROMPT'\[\033[01;34m\]\w '
# An actual ]
SIMPLE_PROMPT=$SIMPLE_PROMPT'\[\033[01;32m\]] '
# The last exit code
SIMPLE_PROMPT=$SIMPLE_PROMPT'[$?]'
# Reset color
SIMPLE_PROMPT=$SIMPLE_PROMPT'\[\033[00m\]'
# The git portion
SIMPLE_PROMPT=$SIMPLE_PROMPT'$(__git_ps1) '
# An actual $
SIMPLE_PROMPT=$SIMPLE_PROMPT'\$ '

# A bash prompt stolen from Luke Smith, broken up into pieces.
# The chroot thingy
LUKE_SMITH_PROMPT='${debian_chroot:+($debian_chroot)}'
# A red [
LUKE_SMITH_PROMPT=$LUKE_SMITH_PROMPT'\[\033[1;31m\][ '
# A yellow username
LUKE_SMITH_PROMPT=$LUKE_SMITH_PROMPT'\[\033[1;33m\]\u '
# A green @
LUKE_SMITH_PROMPT=$LUKE_SMITH_PROMPT'\[\033[1;32m\]@ '
# A blue hostname
LUKE_SMITH_PROMPT=$LUKE_SMITH_PROMPT'\[\033[1;34m\]\h '
# A magenta path
LUKE_SMITH_PROMPT=$LUKE_SMITH_PROMPT'\[\033[1;35m\]\w '
# A red ]
LUKE_SMITH_PROMPT=$LUKE_SMITH_PROMPT'\[\033[1;31m\]] '
# The last exit code in red
LUKE_SMITH_PROMPT=$LUKE_SMITH_PROMPT'\[\033[1;31m\][$?]'
# Reset color
LUKE_SMITH_PROMPT=$LUKE_SMITH_PROMPT'\[\033[00m\]'
# The git portion
LUKE_SMITH_PROMPT=$LUKE_SMITH_PROMPT'$(__git_ps1) '
# An actual $
LUKE_SMITH_PROMPT=$LUKE_SMITH_PROMPT'\$ '

# Set the bash prompt.
PS1=$LUKE_SMITH_PROMPT

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
        for priv_key in `find ~/ssh_keys -type f -name id_rsa* | grep -v ".pub$"`;
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

# Add xterm transparency.
if [ -n "$XTERM_VERSION" ]; then
    transset 0.8 --id "$WINDOWID" >/dev/null
fi
# Add urxvt transparency.
if [ -n "$COLORTERM" ]; then
    transset 0.8 --id "$WINDOWID" >/dev/null
fi

#
# Start screen by default.
#

if [ "$TERM" != "linux" -a -z "$STY" ]; then
    exec screen -A
fi
