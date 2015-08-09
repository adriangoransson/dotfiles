#!/bin/zsh

DOTFILES=$(dirname $0:A)

if [[ `uname` == 'Darwin' ]]; then
    ln -s "$DOTFILES/Packages/User" "$HOME/Library/Application Support/Sublime Text 3/Packages"
fi
