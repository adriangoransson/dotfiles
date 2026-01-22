function format_seconds --argument-names seconds
    function __format_seconds_pad --description "zero-pad numbers to 2 character length (0x)"
        string pad -c 0 -w 2 $argv[1]
    end

    set minutes $(math --scale 0 "$seconds / 60")
    set seconds $(math --scale 0 "$seconds % 60")

    if test $minutes -gt 0
        echo "$(__format_seconds_pad $minutes):$(__format_seconds_pad $seconds)"
    else
        echo $seconds
    end
end
