# Add alias for aggregated uptime since last graceful shutdown

if [[ -x $(command -v tuptime) ]]
then
	function tuptime-graceful () {
		local tuptime_since
		local temp_array
		while read -r line 
		do
			if [[ "${line}" =~ ' BAD ' ]]
			then
				read -r -a temp_array <<< "${line}"
				tuptime_since=$(( temp_array[0] + 1 ))
				break
			fi
		done < <(tuptime --table --order e --reverse)
		tuptime --since "${tuptime_since}"
	}
fi
