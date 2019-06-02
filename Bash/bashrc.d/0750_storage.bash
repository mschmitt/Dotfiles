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

function find_md_states {
	# Tested working

	local GOT_DEGRADED
	local OUTPUT
	local MDNAME

	GOT_DEGRADED=0
	OUTPUT='Degraded MD:'

	if [[ -d /sys/devices/virtual/block/ ]]
	then
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
	fi
}
find_md_states

function find_md_mismatch_cnt {
	local CNT
	for CNT in $(ls /sys/block/md*/md/mismatch_cnt)
	do
		if [[ $(cat $CNT) -ne 0 ]]
		then
			echo "$CNT is $(cat $CNT)"
		fi
	done
}
find_md_mismatch_cnt

function find_smarthealth {
	# Never tested

	local GOT_ERROR
	local OUTPUT
	local OUTPUT_TEMP
	local SCSIDISK

	GOT_ERROR=0
	OUTPUT='Check SMART health on:'
	OUTPUT_TEMP='Disk temperatures:'
	if type smartctl >/dev/null 2>&1 && [[ $UID -eq 0 ]]
	then
		for SCSIDISK in $(find /sys/class/scsi_disk/*/device/block -mindepth 1 -maxdepth 1)
		do
			SCSIDISK=/dev/$(basename $SCSIDISK)
			TEMPFILE=$(mktemp)
			timeout --kill-after=5 5 smartctl -a $SCSIDISK > $TEMPFILE
			if ! grep -q 'SMART overall-health self-assessment test result: PASSED' $TEMPFILE ||
				[[ $(awk '/Offline_Uncorrectable/{print $10}' < $TEMPFILE) -ne 0 ]]
			then
				OUTPUT="$OUTPUT $SCSIDISK"
				GOT_ERROR=1
			fi
			if grep -q Temperature_ $TEMPFILE
			then
				OUTPUT_TEMP="$OUTPUT_TEMP $(awk '/Temperature_/{print $10}' < $TEMPFILE | head -n 1)°C"
			fi
			rm $TEMPFILE
		done
	fi
	echo "$OUTPUT_TEMP"
	if [[ $GOT_ERROR != 0 ]]
	then
		echo "$OUTPUT"
	fi
}
find_smarthealth

# vim: filetype=sh
