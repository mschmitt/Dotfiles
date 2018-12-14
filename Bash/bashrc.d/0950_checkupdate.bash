# Check for updates

# This field updated by git pre-commit hook:
LOCAL_TIMESTAMP=1544819320

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
	GITHUB_REST_URL=https://api.github.com/repos/mschmitt/Dotfiles
	GITHUB_UPDATED_AT=$(curl --silent --show-error "$GITHUB_REST_URL" | jshon -e 'updated_at' -u)
	GITHUB_TIMESTAMP=$(date --date="$GITHUB_UPDATED_AT" +%s)
	if [[ $GITHUB_TIMESTAMP -gt $LOCAL_TIMESTAMP ]]
	then
		echo "Dotfiles update available."
	else
		echo "No update available."
	fi
fi

touch "$SCRIPTFILE"
