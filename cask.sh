APPS="iterm2 firefox-beta dropbox google-drive fantastical alfred flux sublime-text3 mplayerx steam skype spotify google-chrome"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew install caskroom/cask/brew-cask

brew tap caskroom/versions

for APP in $APPS; do
    brew cask install $APP
done

brew cask alfred link
