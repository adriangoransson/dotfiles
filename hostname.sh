if [[ `uname` == "Darwin" ]]; then
    COMMAND="sudo scutil --set HostName $1"
else
    COMMAND="sudo hostname $1"
fi

echo $COMMAND
$($COMMAND)
