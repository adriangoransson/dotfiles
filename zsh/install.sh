#!/bin/zsh

dotfiles=$HOME/.dotfiles

# Install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Prezto files
ln -s "$HOME/.zprezto/runcoms/zprofile" "$HOME/.zprofile"
ln -s "$HOME/.zprezto/runcoms/zshenv" "$HOME/.zshenv"
ln -s "$HOME/.zprezto/runcoms/zlogin" "$HOME/.zlogin"

# Personal configuration
ln -s "$dotfiles/zsh/.zpreztorc" "$HOME/.zpreztorc"
ln -s "$dotfiles/zsh/.zshrc" "$HOME/.zshrc"

chsh -s /bin/zsh
