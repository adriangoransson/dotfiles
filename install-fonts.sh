#!/bin/zsh

if [[ `uname` != 'Darwin' ]]; then
    echo "OSX only"
    exit 1
fi

echo "Fetching and unpacking DejaVu Fonts..."
# Fetch the latest deja vu sans. L flag follows redirects. -s is silent mode.
curl -L -s http://sourceforge.net/projects/dejavu/files/latest/download | tar xz

echo "Moving fonts to ~/Library/Fonts/"
mv dejavu*/ttf/* ~/Library/Fonts/

echo "Removing unpacked files."
rm -rf dejavu*
