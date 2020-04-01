# vim:foldmethod=syntax

_zshrc_start_zim() {
    # Define zim location
    export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

    # Start zim
    [[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh
}

_zshrc_prompt() {
    fpath=($fpath "$HOME/.zprompts")
    autoload -Uz promptinit && promptinit

    prompt amini
}

_zshrc_env() {
    export PATH=$PATH:~/bin

    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8

    export EDITOR='vim'
    export VISUAL='vim'

    # https://stackoverflow.com/a/36524681
    export GPG_TTY=$(tty)
}

_zshrc_aliases() {
    if [ "$(uname)" = 'Darwin' ]; then
        alias ls='ls -G'
        alias jobs='jobs -d'
    elif [ "$(uname)" = 'Linux' ]; then
        alias ls='ls --color'
    fi

    alias rm='rm -vi'
    alias cp='cp -vi'
    alias mv='mv -vi'

    alias g='git'
    alias vp='vimpager'

    alias history='history -dD' # show timestamp + elapsed time
}

_zshrc_misc_opts() {
    bindkey -M vicmd 'K' run-help
}

_zshrc_source_local_rc() {
    local LOCALRC="$HOME/.zshrc.local"

    [[ -f "$LOCALRC" ]] && source "$LOCALRC"
}

_zshrc_start_zim
_zshrc_prompt

_zshrc_env
_zshrc_aliases
_zshrc_misc_opts
_zshrc_source_local_rc
