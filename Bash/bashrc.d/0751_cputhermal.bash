# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

if [[ $UID -ne 0 ]]
then
	return
fi

if [[ "$UNAME_S" != "Linux" ]]
then
	return
fi

function temperature {
	local DIR
	local TYPE
	local RAWTEMP
	if [[ ! -d /sys/class/thermal/thermal_zone0 ]]
	then
		return
	fi
	for DIR in /sys/class/thermal/thermal_zone*
	do
		read -r TYPE < "$DIR/type"
		if [[ "$TYPE" =~ (x86_pkg_temp|bcm2835_thermal|cpu-thermal) ]]
		then
			read -r RAWTEMP < "$DIR/temp"
			printf "CPU core temperature: %s°\n" "$(( $RAWTEMP / 1000 ))"
		fi
	done
}
temperature

# vim: filetype=sh
