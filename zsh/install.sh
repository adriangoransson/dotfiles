#!/bin/zsh

DOTFILES=$(dirname $0:A)
CHSH="chsh -s /bin/zsh"

# Install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Prezto files
ln -s "$HOME/.zprezto/runcoms/zprofile" "$HOME/.zprofile"
ln -s "$HOME/.zprezto/runcoms/zshenv" "$HOME/.zshenv"
ln -s "$HOME/.zprezto/runcoms/zlogin" "$HOME/.zlogin"

# Personal configuration
ln -s "$DOTFILES/.zpreztorc" "$HOME/.zpreztorc"
ln -s "$DOTFILES/.zshrc" "$HOME/.zshrc"

echo $CHSH
eval $CHSH
