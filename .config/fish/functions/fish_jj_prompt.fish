function fish_jj_prompt
    if not command -sq jj
        return 1
    end

    # Closest bookmark: https://github.com/jj-vcs/jj/discussions/6958
    set info "$(jj log 2>/dev/null --no-graph --ignore-working-copy --color=always \
        -r 'latest(coalesce(heads(::@ & bookmarks()), fork_point(@ | trunk())))' \
        -T 'surround("(",")", bookmarks)'
        )"
    or return 1

    if test -n "$info"
        printf ' %s' $info
    end
end
