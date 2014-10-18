#!/bin/zsh

dotfiles=$(dirname $0:A)

setopt EXTENDED_GLOB

for i in $dotfiles/^install.sh(.N); do
	ln -s $i $HOME/$(basename $i)
done

for i in $dotfiles/.*; do
	ln -s $i $HOME/$(basename $i)
done
