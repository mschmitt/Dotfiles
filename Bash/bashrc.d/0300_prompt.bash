# Shell prompt depends on environment. Avoid DHCP hostnames at all cost.
PROMPTHOST=$(hostname -s)
if [[ "$UNAME_S" == "Darwin" ]]
then
	if [[ "$(scutil --get ComputerName)" =~ "macbook" ]]
	then
		PROMPTHOST=macbook
	fi
fi

# Fail gracefully if __git_ps1 is missing
if type -t __git_ps1 >/dev/null 2>&1
then
	export PS1="[\u@$PROMPTHOST \w\$(__git_ps1 '(%s)')]\\$ "
else
	echo "GIT prompt not installed, srsly."
	export PS1="[\u@$PROMPTHOST \w]\\\$ "
fi

# vim: filetype=sh
