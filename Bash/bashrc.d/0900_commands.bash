# Run my encfs helper script
test -x ~/bin/encfsmount && ~/bin/encfsmount

if [[ "$UNAME_S" == "CYGWIN_NT-10.0" ]]
then
	"${HOME}/bin/ssh-agent-bootstrap"
	. "${HOME}/.ssh/agent.env" >/dev/null
else
	ssh-add -l >/dev/null 2>&1 || ssh-add
fi

# vim: filetype=sh
