# Run my encfs helper script
test -x ~/bin/encfsmount && ~/bin/encfsmount

if [[ "$UNAME_S" == "CYGWIN_NT-10.0" ]]
then
	"${HOME}/bin/ssh-agent-bootstrap"
	. "${HOME}/.ssh/agent.env" >/dev/null
else
	ssh-add -l >/dev/null 2>&1 || ssh-add
fi

# Symlinks for the /cygdrive hierarchy
if [[ "$UNAME_S" == "CYGWIN_NT-10.0" ]]
then
	for DRIVE in $(ls /cygdrive)
	do 
		[[ -L "/$DRIVE" ]] || 
		  ln --verbose --symbolic --no-dereference "/cygdrive/$DRIVE" "/$DRIVE"
	done
fi

# vim: filetype=sh
