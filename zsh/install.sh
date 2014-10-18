#!/bin/zsh

dotfiles=$(dirname $0:A)

# Install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Prezto files
ln -s "$HOME/.zprezto/runcoms/zprofile" "$HOME/.zprofile"
ln -s "$HOME/.zprezto/runcoms/zshenv" "$HOME/.zshenv"
ln -s "$HOME/.zprezto/runcoms/zlogin" "$HOME/.zlogin"

# Personal configuration
ln -s "$dotfiles/.zpreztorc" "$HOME/.zpreztorc"
ln -s "$dotfiles/.zshrc" "$HOME/.zshrc"

chsh -s /bin/zsh
