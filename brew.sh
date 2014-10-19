PROGRAMS="git zsh curl htop-osx httpie jq nmap node pv python python3 ssh-copy-id the_silver_searcher tig vimpager vim wget"

brew update
brew upgrade

for PROGRAM in $PROGRAMS; do
    brew install $PROGRAM
done

brew cleanup
