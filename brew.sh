# vim: set ft=sh

if [[ `uname` != 'Darwin' ]]; then
    echo "OSX only"
    exit 1
fi

INSTALLED=0

command -v brew && INSTALLED=1

if [[ $INSTALLED -eq 0 ]]; then
    echo "Installing brew... Let's hope this is safe!"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

PROGRAMS="git zsh curl htop-osx httpie jq nmap node pv python python3 ssh-copy-id the_silver_searcher tig vimpager wget"

brew update
brew upgrade

for PROGRAM in $PROGRAMS; do
    brew install $PROGRAM
done

brew cleanup