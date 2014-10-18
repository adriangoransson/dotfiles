#!/bin/zsh

dotfiles=$(dirname $0:A)

if [[ `uname` == 'Darwin' ]]; then
    ln -s "$dotfiles/Packages/User" "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
fi
