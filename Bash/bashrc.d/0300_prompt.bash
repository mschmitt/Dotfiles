# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

# Shell prompt depends on environment. Avoid DHCP hostnames at all cost.
PROMPTHOST=$(hostname -s)
if [[ "$UNAME_S" == "Darwin" ]]
then
	if [[ "$(scutil --get ComputerName)" =~ macbook ]]
	then
		PROMPTHOST=macbook
	fi
fi
if [[ -f /etc/hostname ]]
then
	PROMPTHOST=$(cat /etc/hostname)
fi

# Show original user if su or sudoed to another one
USERAS=''
# Need to call logname directly to catch broken logname behind lightdm
if /usr/bin/logname >/dev/null 2>&1 && [[ $(/usr/bin/logname) != "$USER" ]]
then
	USERAS="$(/usr/bin/logname)->"
fi

# Fail gracefully if __git_ps1 is missing
if type -t __git_ps1 >/dev/null 2>&1
then
	export PS1="\$(mc_subsh)[$USERAS\u@$PROMPTHOST \w\$(__git_ps1 '(%s)')]\\$ "
else
	export PS1="\$(mc_subsh)[$USERAS\u@$PROMPTHOST \w]\\\$ "
fi

# Trim CWD in prompt to this many elements
PROMPT_DIRTRIM=3

# xterm and screen titles
# Hint: The overkill window titling in Apple Terminal is best disabled
# directly in Terminal.app's settings.
function mypromptcmd() {
	# xterm - This is what I want 99.9% of the time
	builtin printf '\e]0;%s\a' "$PROMPTHOST"
	# screen
	if [[ "$TERM" == "screen" ]]
	then
		builtin printf '\ek%s\e\\' "$PROMPTHOST"
		# Be more aggressive and send the sequence
		# for xterm title uninterpreted:
		printf '\eP\e]0;%s\a\e\\' "$PROMPTHOST"
	fi
}
PROMPT_COMMAND="mypromptcmd"

# Detect Midnight Commander Subshell and show {mc}
function mc_subsh() {
	if [[ -v MC_SID ]]
	then
		echo '{mc}'
	fi
}
# vim: filetype=sh
