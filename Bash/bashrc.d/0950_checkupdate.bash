# Check for updates

# This field updated by git pre-commit hook:
LOCAL_TIMESTAMP=1637259335

# Check for update no more frequently than every 7 days
# Keep track by touching this file itself.
SCRIPTFILE="${BASH_SOURCE[0]}"
NOWTIME=$(date +%s)
case "$UNAME_S" in
	CYGWIN_NT*)
		SCRIPTTIME=$(stat --format '%Y' "$SCRIPTFILE")
		;;
	"Darwin")
		SCRIPTTIME=$(stat -f '%m' "$SCRIPTFILE")
		;;
	"Linux"|*)
		SCRIPTTIME=$(stat --format '%Y' "$SCRIPTFILE")
		;;
esac

let AGE=$NOWTIME-$SCRIPTTIME
let MINAGE=60*60*24*7

if [[ $AGE -gt $MINAGE ]]
then
	# Update time at upstream
	echo -n "Checking for Dotfiles update: "
	GITHUB_HELPER_URL='https://scsy.de/cgi-bin/github-Dotfiles-epoch-helper'
	GITHUB_UPDATED_AT=$(curl --silent --show-error --max-time 5 "$GITHUB_HELPER_URL")
	if [[ $GITHUB_UPDATED_AT -gt $LOCAL_TIMESTAMP ]]
	then
		echo "Dotfiles update available."
	else
		echo "No update available."
	fi
fi

touch "$SCRIPTFILE"
