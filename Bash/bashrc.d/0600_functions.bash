# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

# poke() - Send generic message to my mobile, e.g. after a long-running task has finished.
#
# Inspired by: https://twitter.com/shezoidic/status/966663437001592832
#
# /path/to/long-running; poke
#         - OR -
# poke /path/to/long-running

function poke {
	local MESSAGE
	local RC
	local TEMPFILE
	local PUSHOVER_POKE_OUT
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

# myip() Look own AS/Org
function myip() {
	local IP4
	local ORG4
	local IP6
	local ORG6

	test -e /usr/local/bin/myip && echo "/usr/local/bin/myip kann weg."

	IP4=$(curl -s http://v4.ipv6-test.com/api/myip.php) &&
	ORG4=$(curl -s http://ipinfo.io/$IP4/org) &&
	echo IPv4: $IP4 / $ORG4

	IP6=$(curl -s http://v6.ipv6-test.com/api/myip.php) &&
	ORG6=$(curl -s http://ipinfo.io/$IP6/org) &&
	echo IPv6: $IP6 / $ORG6
}

function cygupdate() {
	if [[ "$UNAME_S" == "CYGWIN_NT-10.0" ]]
	then
		curl https://cygwin.com/setup-x86_64.exe > /tmp/setup-x86_64.exe
		chmod +x /tmp/setup-x86_64.exe
		 /tmp/setup-x86_64.exe -q -n # -O -s http://ftp.mirrorservice.org
	fi
}

rescan-scsi() {
	if [[ -d /sys/class/scsi_host/ ]]
	then
		for HOST in /sys/class/scsi_host/host*
		do
			echo $HOST
			echo '- - -' > $HOST/scan
		done
	else
		echo "Nothing to do here."
	fi
}
		

	
	

# vim: filetype=sh
