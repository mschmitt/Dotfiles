# Skip if running non-interactively
if [[ ! -t 0 ]]
then
	return
fi

# Ad-hoc-benchmarks

function bonnie-here() {
	local UNPRIV
	local CMD
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
	local CMD
	CMD="sysbench --num-threads=$(grep 'processor' /proc/cpuinfo | sort -u | wc -l) --test=cpu run"
	echo "$CMD"
	$CMD
}

function openssl-speed() {
	local THREADS=$(grep 'processor' /proc/cpuinfo | sort -u | wc -l)
	local I
	local PIDS="To kill all processes: kill -9"
	for (( I=1 ; I<=$THREADS ; I++ ))
	do
	    openssl speed 2>/dev/null &
	    PIDS="$PIDS $!"
	done
	echo -e "\n\n$PIDS\n\n"
}
	
	

# vim: filetype=sh
