# Source Prezto by Sorin Ionescu <sorin.ionescu@gmail.com>
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

zshrc_init_common() {
    PROMPT='%F{magenta}[%m]%f %F{yellow}%2~%f${vcs_info_msg_0_} » '

    export PATH=$PATH:~/bin

    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8

    export EDITOR='vim'
    export VISUAL='vim'

    # Don't push lines that begin with space onto the history
    setopt hist_ignore_space

    # Remove duplicates from $path (array that is synced with $PATH)
    typeset -U path

    bindkey -M vicmd 'K' run-help

    alias vp='vimpager'
}

zshrc_init_linux() {
    if [[ $(uname) != 'Linux' ]]; then return; fi

    alias ls='ls --color'
}

zshrc_init_macos() {
    if [[ $(uname) != 'Darwin' ]]; then return; fi

    alias ls='ls -G'
    alias jobs='jobs -d'
}

zshrc_source_local() {
    local LOCALRC="$HOME/.zshlocalrc"

    if [[ -f "$LOCALRC" ]]; then
        source "$LOCALRC"
    fi
}


zshrc_init_common
zshrc_init_linux
zshrc_init_macos
zshrc_source_local
