dotfiles="$HOME/.dotfiles"

if [[ `uname` == 'Darwin' ]]; then
    ln -s "$dotfiles/sublime/Packages/User" "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
fi
