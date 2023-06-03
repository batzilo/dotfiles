# Set the bash prompt.

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

# Set the bash prompt.
PS1=$SIMPLE_PROMPT
