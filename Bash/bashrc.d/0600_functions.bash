# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

function archive_mount {
	grep -q backupserver /etc/hostname || return
	cryptdisks_start ARCHIVE_USB
	mount -v /usb
	ls -l /usb
}

function archive_umount {
	grep -q backupserver /etc/hostname || return
	umount -v /usb
	cryptdisks_stop ARCHIVE_USB
}
	

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
			local BEFORE=$(dmesg)
			echo $HOST
			echo '- - -' > $HOST/scan
			diff <(echo "$BEFORE") <(dmesg)
		done
	else
		echo "Nothing to do here."
	fi
}
		
function nmon {
	echo "Autogenerating nmon diskgroups. Run \"command nmon\" for default behaviour."
	enable -f /usr/lib/bash/realpath realpath
	local DGFILE=$(mktemp)
	local FIELD
	grep '^/dev/' /etc/mtab | 
	while read -a FIELD
	do
		# Canonicalize Device name
		local DEVICE=$(realpath "${FIELD[0]}")

		# Strip the /dev/ from the beginning
		local ICE=${DEVICE/\/dev\//}

		# shorten the mount point by compressing all 
		# /paths/leading/to/mountpoint 
		# into single character /p/l/t/mountpoint
		# https://stackoverflow.com/a/22261454
		local MOUNTPOINT="${FIELD[1]}"
		if [[ "$MOUNTPOINT" =~ ^/boot ]]
		then
			continue
		fi
		local REGEX='(.*/)(.)[^/]+(/.+)'
		while [[ "$MOUNTPOINT" =~ $REGEX ]]
		do
			MOUNTPOINT="${BASH_REMATCH[1]}${BASH_REMATCH[2]}${BASH_REMATCH[3]}"
		done
		echo "$MOUNTPOINT $ICE" >> "$DGFILE"
	done
	lsblk | grep disk |
	while read -a DISK
	do
		echo "/dev/${DISK[0]} ${DISK[0]}" >> "$DGFILE"
	done
	echo ''
	cat "$DGFILE"
	sleep 1
	NMON="cng" command nmon -g "$DGFILE"
	rm "$DGFILE"
}

function condensepath {
	local PATHNAME="$1"
	local REGEX='(.*/)(.)[^/]+(/.+)'
	while [[ "$PATHNAME" =~ $REGEX ]]
	do
		PATHNAME="${BASH_REMATCH[1]}${BASH_REMATCH[2]}${BASH_REMATCH[3]}"
	done
	echo "$PATHNAME"
}

# mvtop - Move to parent: Move specified files to parent directory
# and clean up what remains.
function mvtop() {
	local file
	local rmdir="$(pwd)"
	for file in "$@"
	do
		mv --verbose --interactive "${file}" ..
	done
	cd ..
	rm --verbose --recursive --interactive "${rmdir}"
}
	
# vim: filetype=sh
