# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/batzilo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors && colors

autoload -U promptinit
promptinit
prompt off

# my custom prompt
PROMPT="\
%{$fg[red]%}%(?..[%?] )%{$reset_color%}\
%{$fg[green]%}%n%{$reset_color%}\
%{$fg[red]%}@%{$reset_color%}\
%{$fg[cyan]%}%m%{$reset_color%}\
 %{$fg[yellow]%}%~%{$reset_color%}\
 %#\
 "
