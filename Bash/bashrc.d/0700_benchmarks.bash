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
	CMD="sysbench --num-threads=$(python -c 'import multiprocessing as mp; print(mp.cpu_count())') --test=cpu run"
	echo "$CMD"
	$CMD
}

function openssl-speed() {
	local THREADS=$(python -c 'import multiprocessing as mp; print(mp.cpu_count())')
	if [[ -x $(command -v parallel) ]]
	then
		seq 1 "$THREADS" | parallel --line-buffer --tagstring='{#}' --max-args=0 openssl speed
	else
		local I
		local PIDS="To kill all processes: kill -9"
		for (( I=1 ; I<=$THREADS ; I++ ))
		do
		    openssl speed 2>/dev/null &
		    PIDS="$PIDS $!"
		done
		echo -e "\n\n$PIDS\n\n"
	fi
}
	
	

# vim: filetype=sh
