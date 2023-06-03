# Set the bash prompt.

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
