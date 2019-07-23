_zshrc_start_zim() {
    # Define zim location
    export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

    # Start zim
    [[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh
}

_zshrc_prompt() {
    fpath=( "$HOME/.zprompts" $fpath )
    autoload -Uz promptinit && promptinit

    prompt amini
}

_zshrc_init_common() {
    export PATH=$PATH:~/bin

    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8

    export EDITOR='vim'
    export VISUAL='vim'

    bindkey -M vicmd 'K' run-help

    alias vp='vimpager'
    alias g='git'
}

_zshrc_init_linux() {
    if [[ $(uname) != 'Linux' ]]; then return; fi

    alias ls='ls --color'
}

_zshrc_init_macos() {
    if [[ $(uname) != 'Darwin' ]]; then return; fi

    alias ls='ls -G'
    alias jobs='jobs -d'
}

_zshrc_source_local() {
    local LOCALRC="$HOME/.zshlocalrc"

    if [[ -f "$LOCALRC" ]]; then
        source "$LOCALRC"
    fi
}


_zshrc_start_zim
_zshrc_prompt

_zshrc_init_common
_zshrc_init_linux
_zshrc_init_macos
_zshrc_source_local
