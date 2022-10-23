_zshrc_prompt() {
    fpath=($fpath "$HOME/.zfunctions")
    autoload -Uz promptinit && promptinit

    prompt amini
}

_zshrc_env() {
    export PATH="$HOME/.local/bin:$PATH"

    export EDITOR='nvim'
    export VISUAL='nvim'

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
    # Disable scroll lock on ctrl-s
    # https://unix.stackexchange.com/questions/72086/ctrl-s-hangs-the-terminal-emulator
    stty -ixon

    bindkey -v                        # vi bindings
    bindkey -M viins '^S' vi-cmd-mode # ctrl-s = escape
    bindkey -M vicmd 'K' run-help     # open man page for the currently typed command

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

    # ------------------
    # Initialize modules
    # ------------------

    ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
    if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
      # Download zimfw script if missing.
      if (( ${+commands[curl]} )); then
        curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
      else
        mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
      fi
    fi
    if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
      # Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
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

_zshrc_post_zim() {
    # override this function in local rc if needed.
    :
}

# --------------------------------------------------------------------------- #

_zshrc_prompt

_zshrc_env
_zshrc_aliases
_zshrc_misc_opts
_zshrc_source_local_rc

_zshrc_start_zim
_zshrc_post_zim

# My own little project finder that I use to cd into git repos located in
# $CODE_DIR (defaults to $HOME/code). It works with fzy and fd but will fall
# back to fzf or find if necessary.
p() {
    local dir=${CODE_DIR:-"$HOME/code"}

    local fuzzy=''
    (( $+commands[fzf] )) && fuzzy=fzf
    # The default 10 lines for fzy feels a bit cramped.
    (( $+commands[fzy] )) && fuzzy='fzy -l 100'

    test -z "$fuzzy" && echo "No fuzzy finder installed" && return 1

    local find_cmd="find '$dir' -name '*.git' -type d"
    (( $+commands[fd] )) && \
        find_cmd="fd --hidden --type d --glob '*.git' '$dir'"

    # Find all git folders and remove the:
    # - common directory prefix $dir for all entries.
    # - .git suffix to get the project root.
    local projects=$(eval "$find_cmd" | sed -E "s|$dir/(.*)/.git$|\1|")

    test -z "$projects" && echo "No git roots found in $dir" && return 1

    local chosen=$(echo "$projects" | eval "$fuzzy")

    # Make sure a dir was chosen so we don't cd to $dir.
    test -z "$chosen" && return

    cd "$dir/$chosen"
}
