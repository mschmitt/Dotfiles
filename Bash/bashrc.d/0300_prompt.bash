# Shell prompt depends on environment. Avoid DHCP hostnames at all cost.
PROMPTHOST=$(hostname -s)
if [[ "$UNAME_S" == "Darwin" ]]
then
	if [[ "$(scutil --get ComputerName)" =~ macbook ]]
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

# xterm and screen titles
# Hint: The overkill window titling in Apple Terminal is best disabled
# directly in Terminal.app's settings.
function mypromptcmd() {
	# xterm - This is what I want 99.9% of the time
	builtin printf '\e]0;%s\a' "$PROMPTHOST"
	# screen title only if the terminal is screen
	if [[ "$TERM" = "screen" ]]
	then
		builtin printf '\ek%s\e\\' "$PROMPTHOST"
	fi
}
PROMPT_COMMAND="mypromptcmd"

# vim: filetype=sh
