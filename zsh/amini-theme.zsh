# amini theme, derived from gitster
# https://github.com/zimfw/zimfw/blob/2d1aea3b745ce82364acd9c7f718ac2bcf47a268/modules/prompt/themes/gitster.zsh-theme

# Requires the `git-info` zmodule to be included in the .zimrc file.

prompt_amini_git() {
    [[ -n ${git_info} ]] && print -n "${(e)git_info[prompt]}"
}

prompt_amini_precmd() {
    (( ${+functions[git-info]} )) && git-info
}

prompt_amini_setup() {
    autoload -Uz add-zsh-hook && add-zsh-hook precmd prompt_amini_precmd

    prompt_opts=(cr percent sp subst)

    zstyle ':zim:git-info' verbose 'yes'

    zstyle ':zim:git-info:action' format '(%s)'

    zstyle ':zim:git-info:branch' format '%b'
    zstyle ':zim:git-info:commit' format '%c'

    zstyle ':zim:git-info:indexed' format '%F{green}●'
    zstyle ':zim:git-info:unindexed' format '%F{yellow}●'
    zstyle ':zim:git-info:untracked' format '%F{red}●'

    zstyle ':zim:git-info:keys' format \
        'prompt' " (%b%c%i%I%u%S%f)%s"

    PROMPT=''

    PROMPT+='%F{magenta}[%m]%f '    # [hostname]
    PROMPT+='%F{yellow}%2~%f'       # 2 layers of dirs from ~
    PROMPT+="\$(prompt_amini_git) " # (git status)
    PROMPT+='%(?..%F{red})'         # begin red if $? != 0
    PROMPT+='»%f '                  # symbol and end color
}

prompt_amini_setup "${@}"

