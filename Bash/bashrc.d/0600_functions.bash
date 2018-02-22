# poke() - Send generic message to my mobile, e.g. after a given task has finished.
function poke {
	if [[ -s ~/.poke.pushover ]]
	then
		source ~/.poke.pushover
		TEMPFILE=$(mktemp)
		curl -s --form-string token="$PUSHOVER_POKE_APP" \
			--form-string title="POKE" \
			--form-string user="$PUSHOVER_POKE_USER" \
			--form-string message="from $(tty) on $(hostname -s)" \
			https://api.pushover.net/1/messages.json > "$TEMPFILE"
		PUSHOVER_POKE_OUT=$(cat "$TEMPFILE")
		echo "Call to Pushover returned: $? ($PUSHOVER_POKE_OUT)"
	else
		echo "~/.poke.pushover is missing."
		return 0
	fi
}

# vim: filetype=sh
