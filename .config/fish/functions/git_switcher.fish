function git_switcher --description 'Git repository directory switcher' --argument-names root
    set -l max_depth 3
    set -l cmd find "$root" -name "'*.git'" -type d -prune -maxdepth "$max_depth"

    if command -sq fd
        set cmd fd -u --prune --max-depth "$max_depth" --type d --glob "'*.git'" "$root"
    end

    set -l dir $(eval "$cmd" \
        | string replace "$root" '' \
        | string replace -r '/?.git/?$' '' \
        | fzf --height 30 --layout reverse)

    test -z "$dir" && return

    cd "$root/$dir"
end
