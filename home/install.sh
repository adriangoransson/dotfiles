#!/bin/zsh

DOTFILES=$(dirname $0:A)

setopt EXTENDED_GLOB

for i in $DOTFILES/^install.sh(.N); do
	ln -s $i $HOME/$(basename $i)
done

for i in $DOTFILES/.*; do
	ln -s $i $HOME/$(basename $i)
done
