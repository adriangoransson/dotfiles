function fish_prompt --description 'Write out the prompt'
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red

    # Color the prompt differently when we're root
    set -l color_user $fish_color_user
    set -l color_cwd $fish_color_cwd
    set -l suffix '»'
    set -l user $USER
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set color_user $fish_color_cwd_root
        set suffix '#'
    else if test $user = adrian
        # Skip showing "adrian@"
        set user ''
    end

    if test -n "$user"
        set user $(set_color $color_user) $user $normal @
    end

    set -l jobs $(jobs | count)
    if test $jobs -gt 0
        set jobs " $(set_color yellow)$jobs" $normal
    else
        set jobs ''
    end

    set -l color_suffix $normal
    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings

        switch $fish_bind_mode
            case default
                set color_suffix $(set_color cyan)
            case replace
                set color_suffix $(set_color red)
            case visual
                set color_suffix $(set_color yellow)
        end
    end

    echo -n -s \
        $(set_color magenta) '[' $user $(set_color magenta) $(prompt_hostname) '] ' \
        (set_color $color_cwd) (prompt_pwd -D 2) $normal \
        (fish_vcs_prompt) $normal \
        " "$prompt_status \
        $jobs \
        ' ' $color_suffix $suffix $normal ' '
end
