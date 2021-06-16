_zshrc_prompt() {
    fpath=($fpath "$HOME/.zfunctions")
    autoload -Uz promptinit && promptinit

    prompt amini
}

_zshrc_env() {
    export PATH="$HOME/.local/bin:$PATH"

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
    bindkey -v                    # vi bindings
    bindkey -M vicmd 'K' run-help # open man page for the currently typed command

    # Remove older command from the history if a duplicate is to be added.
    setopt HIST_IGNORE_ALL_DUPS
    HISTFILE="${HOME}/.zhistory"
}

_zshrc_source_local_rc() {
    local LOCALRC="$HOME/.zshrc.local"

    [[ -f "$LOCALRC" ]] && source "$LOCALRC"
}

_zshrc_start_zim() {
    # Remove path separator from WORDCHARS.
    WORDCHARS=${WORDCHARS//[\/]}

    # termtitle
    # ---------
    # See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
    zstyle ':zim:termtitle' format '%n@%m:%3~'


    # zsh-syntax-highlighting
    # -----------------------
    # See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

    # Initialize modules
    # ------------------
    if [[ ${ZIM_HOME}/init.zsh -ot ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
      # Update static initialization script if it's outdated, before sourcing it
      source ${ZIM_HOME}/zimfw.zsh init -q
    fi
    source ${ZIM_HOME}/init.zsh

    # Post-init module configuration
    # ------------------------------

    # zsh-history-substring-search
    # ----------------------------
    # Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down

    # Bind up and down keys
    zmodload -F zsh/terminfo +p:terminfo
    if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
      bindkey ${terminfo[kcuu1]} history-substring-search-up
      bindkey ${terminfo[kcud1]} history-substring-search-down
    fi

    bindkey '^P' history-substring-search-up
    bindkey '^N' history-substring-search-down
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
}

# --------------------------------------------------------------------------- #

_zshrc_prompt

_zshrc_env
_zshrc_aliases
_zshrc_misc_opts
_zshrc_source_local_rc

_zshrc_start_zim
