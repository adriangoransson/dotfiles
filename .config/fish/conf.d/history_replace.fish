# Adapted from https://github.com/faho/fish-snippets/blob/973afe8e31a02eeada23d29fc4b53456eda18745/conf.d/abbrs.fish

# A simple version of history expansion - '!!' and '!$'
function histreplace
    switch "$argv[1]"
        case !!
            echo -- $history[1]
            return 0
        case '!$'
            echo -- $history[1] | read -lat tokens
            echo -- $tokens[-1]
            return 0
    end

    return 1
end

abbr --add !! --function histreplace --position anywhere
abbr --add '!$' --function histreplace --position anywhere
