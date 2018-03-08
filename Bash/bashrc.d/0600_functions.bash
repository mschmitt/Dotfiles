# poke() - Send generic message to my mobile, e.g. after a long-running task has finished.
#
# Inspired by: https://twitter.com/shezoidic/status/966663437001592832
#
# /path/to/long-running; poke
#         - OR -
# poke /path/to/long-running

function poke {
	MESSAGE="$(tty) • $(hostname -s)"
	if [[ "$*" ]]
	then
		"$@"
		RC=$?
		MESSAGE="$1 • exit $RC • $(tty) • $(hostname -s)"
	fi
	if [[ -s ~/.poke.pushover ]]
	then
		source ~/.poke.pushover
		TEMPFILE=$(mktemp)
		curl -s --form-string token="$PUSHOVER_POKE_APP" \
			--form-string title="POKE" \
			--form-string user="$PUSHOVER_POKE_USER" \
			--form-string message="$MESSAGE" \
			https://api.pushover.net/1/messages.json > "$TEMPFILE"
		PUSHOVER_POKE_OUT=$(cat "$TEMPFILE")
		echo "Call to Pushover returned: $? ($PUSHOVER_POKE_OUT)"
	else
		echo "~/.poke.pushover is missing."
		return 0
	fi
}

# vim: filetype=sh
