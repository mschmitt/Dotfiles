# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

# yo() - Remix of poke() but for mail, ideally Deltachat.
#
# Inspired by this tweet: https://archive.ph/4ptl2
#
# /path/to/long-running; yo
#         - OR -
# yo /path/to/long-running

function yo {
	local message
	local rc
	local tempfile
	local curl_out
	message="$(tty) - $(hostname -s)"
	if [[ "$*" ]]
	then
		"$@"
		rc=$?
		message="$@ - exit $rc - $(tty) - $(hostname -s)"
	fi
	if [[ -s ~/.yo.smtpcfg ]]
	then
		source ~/.yo.smtpcfg
		tempfile="$(mktemp)"
		curl -s --user "${SMTP_FROM}:${SMTP_PASS}" \
			--mail-from "${SMTP_FROM}" \
			--mail-rcpt "${SMTP_TO}" \
			--header "From: YO <${SMTP_FROM}>" \
			--header "To: ${SMTP_TO}" \
			--header "Subject: YO" \
			--header "Date: $(printf "%(%a, %d %b %Y %H:%M:%S %z)T" -1)" \
			--form-string "=${message}" \
			--write-out '%{response_code} %{errormsg}\n' \
			"${SMTP_SERVER}" > "${tempfile}"
		rc=$?
		curl_out=$(cat "${tempfile}")
		rm "${tempfile}"
		echo "Call to SMTP returned: ${rc} ${curl_out}"
	else
		echo "~/.yo.smtpcfg is missing."
	fi
	return 0
}

# vim: filetype=sh
