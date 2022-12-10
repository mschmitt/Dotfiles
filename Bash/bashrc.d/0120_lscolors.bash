# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

if [ -s ~/.dircolors ] && type dircolors >/dev/null
then
	eval "$(dircolors ~/.dircolors)"
fi

# vim: filetype=sh
