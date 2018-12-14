# Check for updates

# This field updated by git pre-commit hook:
LOCAL_TIMESTAMP=1544823549

# Check for update no more frequently than every 7 days
# Keep track by touching this file itself.
SCRIPTFILE="${BASH_SOURCE[0]}"
SCRIPTTIME=$(stat $SCRIPTFILE --format '%Y')
NOWTIME=$(date +%s)

let AGE=$NOWTIME-$SCRIPTTIME
let MINAGE=3600*24*7

if [[ $AGE -gt $MINAGE ]]
then
	# Update time at upstream
	echo -n "Checking for Dotfiles update: "
	GITHUB_HELPER_URL='https://scsy.de/cgi-bin/github-Dotfiles-helper'
	GITHUB_UPDATED_AT=$(curl --silent --show-error --max-time 5 "$GITHUB_HELPER_URL")
	GITHUB_TIMESTAMP=$(date --date="$GITHUB_UPDATED_AT" +%s)
	if [[ $GITHUB_TIMESTAMP -gt $LOCAL_TIMESTAMP ]]
	then
		echo "Dotfiles update available."
	else
		echo "No update available."
	fi
fi

touch "$SCRIPTFILE"
