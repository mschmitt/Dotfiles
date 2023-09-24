# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

if [[ -z $STY ]]
then
	screen -ls 2>/dev/null | grep -v Socket | grep '[a-zA-Z0-9]'
fi

# vim: filetype=sh
