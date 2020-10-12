# Skip if running non-interactively
if [[ ! -t 0 ]]
then
	return
fi

# Run my encfs helper script

test -x ~/bin/encfsmount && ~/bin/encfsmount

# Symlinks for the /cygdrive hierarchy
if [[ "$UNAME_S" =~ CYGWIN_NT ]]
then
	for DRIVE in $(ls /cygdrive)
	do 
		[[ -L "/$DRIVE" ]] || 
		  ln --verbose --symbolic --no-dereference "/cygdrive/$DRIVE" "/$DRIVE"
	done
fi

# vim: filetype=sh
