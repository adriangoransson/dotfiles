#!/bin/zsh

dotfiles=$(dirname $0:A)

if [[ `uname` == 'Darwin' ]]; then
    ln -s "$dotfiles/Packages/User" "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
    mkdir $HOME/bin
    ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" "$HOME/bin/subl"
fi
