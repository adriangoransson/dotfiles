# amini theme, derived from gitster
# https://github.com/zimfw/zimfw/blob/2d1aea3b745ce82364acd9c7f718ac2bcf47a268/modules/prompt/themes/gitster.zsh-theme

# Requires the `git-info` zmodule to be included in the .zimrc file.

prompt_amini_git() {
    [[ -n ${git_info} ]] && print -n "${(e)git_info[prompt]}"
}

prompt_amini_precmd() {
    (( ${+functions[git-info]} )) && git-info

    LAST_COMMAND_DURATION=0
    if [ -n "$LAST_COMMAND_START" ]; then
        local -F now=EPOCHREALTIME

        LAST_COMMAND_DURATION=$(( now - LAST_COMMAND_START ))

        unset LAST_COMMAND_START
    fi
}

prompt_amini_preexec() {
    [ -z "$1" ] && return

    typeset -gF LAST_COMMAND_START=EPOCHREALTIME
}

prompt_amini_time_elapsed() {
    # use global value or default to 2
    local -F timeout=${COMMAND_TIMER_THRESHOLD:-2}
    (( LAST_COMMAND_DURATION < timeout )) && return

    # zsh rounds to zero so add .5 seconds for nearest int
    local -i dur_seconds=$(( LAST_COMMAND_DURATION + 0.5 ))
    local text=''

    if (( dur_seconds < 60 )); then
        # s
        text+="$dur_seconds"
    else
        # mm:ss
        local -i minutes=$(( dur_seconds / 60 ))
        local -i seconds=$(( dur_seconds % 60 ))

        (( minutes < 10 )) && text+='0'
        text+="$minutes:"

        (( seconds < 10 )) && text+='0'
        text+="$seconds"
    fi

    echo -n "${text}s"
}

prompt_amini_setup() {
    autoload -Uz add-zsh-hook \
        && add-zsh-hook precmd prompt_amini_precmd \
        && add-zsh-hook preexec prompt_amini_preexec

    # enable use of EPOCHREALTIME
    zmodload zsh/datetime

    typeset -gF LAST_COMMAND_DURATION=0

    prompt_opts=(cr percent sp subst)

    zstyle ':zim:git-info' verbose 'yes'

    zstyle ':zim:git-info:action' format '%F{cyan}%s%f '

    zstyle ':zim:git-info:branch' format '%b'
    zstyle ':zim:git-info:commit' format '%c'

    zstyle ':zim:git-info:ahead' format '+%A'
    zstyle ':zim:git-info:behind' format '-%B'

    zstyle ':zim:git-info:indexed' format '%F{green}●'
    zstyle ':zim:git-info:unindexed' format '%F{yellow}●'
    zstyle ':zim:git-info:untracked' format '%F{red}●'

    zstyle ':zim:git-info:keys' format 'prompt' " (%s%b%c%A%B%i%I%u%S%f)"

    # begin red if $? != 0
    local red_if_error='%(?..%F{red})'

    PROMPT=''

    PROMPT+='%F{magenta}[%m]%f '    # [hostname]
    PROMPT+='%F{yellow}%2~%f'       # 2 layers of dirs from ~
    PROMPT+="\$(prompt_amini_git) " # (git status)
    PROMPT+="$red_if_error"
    PROMPT+='»%f '                  # symbol and end color

    RPROMPT="$red_if_error\$(prompt_amini_time_elapsed)%f"
}

prompt_amini_setup "${@}"

