# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

if [[ "$UNAME_S" != "Linux" ]]
then
	return
fi

function find_md_states {
	# Tested working

	GOT_DEGRADED=0
	OUTPUT='Degraded MD:'

	for SYSMD in $(find /sys/devices/virtual/block/ -name 'md' -type d)
	do
		if [[ ! -r "$SYSMD/degraded" ]]
		then
			continue
		fi
		DEGRADED=$(cat "$SYSMD/degraded")
		MDNAME=$(basename $(dirname $SYSMD))
		if [[ $DEGRADED != 0 ]]
		then
			OUTPUT="$OUTPUT /dev/$MDNAME"
			GOT_DEGRADED=1
		fi
	done
	if [[ $GOT_DEGRADED != 0 ]]
	then
		echo "$OUTPUT"
	fi
}
find_md_states

function find_smarthealth {
	# Never tested

	GOT_ERROR=0
	OUTPUT='Check SMART health on: '
	if [[ $(type smartctl >/dev/null 2>&1) && $UID == 0 ]]
	then

		for SCSIDISK in $(find /sys/class/scsi_disk/*/device/block -mindepth 1 -maxdepth 1)
		do
			SCSIDISK=$(basename $SCSIDISK)
			smartctl --quietmode=silent -H $SCSIDISK
			if [[ $? -ne 0 ]]
			then
				OUTPUT="$OUTPUT /dev/$SCSIDISK"
				GOT_ERROR=1
			fi
		done
	fi
	if [[ $GOT_ERROR != 0 ]]
	then
		echo "$OUTPUT"
	fi
}
find_smarthealth

# vim: filetype=sh
