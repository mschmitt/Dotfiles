# Skip if running non-interactively
if [[ ! -t 0 ]]
then
	return
fi

# Ad-hoc-benchmarks

function bonnie-here() {
	UNPRIV=''
	if [[ $UID -eq 0 ]]
	then
		UNPRIV="-u nobody -g $(id -ng nobody)"
	fi
	PATH="$PATH:/usr/sbin"
	CMD="bonnie++ -f -d . -n 0 $UNPRIV -m $(hostname -s)"
	echo "$CMD"
	$CMD
}

function sysbench-cpu() {
	CMD="sysbench --num-threads=$(grep 'processor' /proc/cpuinfo | sort -u | wc -l) --test=cpu run"
	echo "$CMD"
	$CMD
}

# vim: filetype=sh
