# Source Prezto by Sorin Ionescu <sorin.ionescu@gmail.com>
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

PROMPT='%F{magenta}[%m]%f %F{yellow}%2~%f${vcs_info_msg_0_} » '

LOCALRC="$HOME/.zshlocalrc"

export PATH=$PATH:~/bin

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export EDITOR='vim'
export VISUAL='vim'

if [[ `uname` == 'Darwin' ]]; then
    alias ls='ls -G'
    alias jobs='jobs -d'
else
    alias ls='ls --color'
fi

alias vp='vimpager'

if [[ -f $LOCALRC ]]; then
    source $LOCALRC
fi

# Don't push lines that begin with space onto the history
setopt hist_ignore_space

# Remove duplicates from $path (array that is synced with $PATH)
typeset -U path
