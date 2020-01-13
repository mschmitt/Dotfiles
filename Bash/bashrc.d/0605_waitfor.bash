# A slightly overengineered function that waits for things to appear or go away
# waitfor -n address|hostname <-p port> - Wait for network thing to appear
# waitfor -N address|hostname <-p port> - Wait for network thing to go away
# waitfor -f filename 	                - Wait for file to appear
# waitfor -F filename 	                - Wait for file to go away
# External requirements: ping

function waitfor() {
	local option
	local type
	local thing
	local waitfor
	local method='ping'
	unset OPTIND
	unset OPTARG
	while getopts ':n:N:f:F:p:' option
	do
		case "${option}" in
		'n') 
			type='network'
			thing="${OPTARG}"
			waitfor='appeared'
			;;
		'N') 
			type='network'
			thing="${OPTARG}"
			waitfor='gone'
			;;
		'f')
			type='file'
			thing="${OPTARG}"
			waitfor='appeared'
			;;
		'F')
			type='file'
			thing="${OPTARG}"
			waitfor='gone'
			;;
		'p')
			port="${OPTARG}"
			method='tcp'
			;;
		'?')
			cat<<-End
			waitfor -n address|hostname <-p port>
			waitfor -N address|hostname <-p port>
			waitfor -f filename
			waitfor -F filename
			-n/-f - Wait till appeared
			-N/-F - Wait till gone
			End
			unset OPTIND
			unset OPTARG
			return 1
			;;
		esac
	done
	unset OPTIND
	unset OPTARG
	if [[ "${type}" = 'network' ]]
	then
		if [[ "${method}" = 'ping' && "${waitfor}" = 'appeared' ]]
		then
			printf "Waiting for %s to be reachable by Ping." "${thing}"
			while true
			do
				ping -c 2 "${thing}" >/dev/null 2>&1
				if [[ $? -ne 0 ]]
				then
					printf '.'
					sleep 1
				else
					printf " - %s has appeared.\n" "${thing}"
					break
				fi
			done
		elif [[ "${method}" = 'ping' && "${waitfor}" = 'gone' ]]
		then
			printf "Waiting for %s to be no longer reachable by Ping." "${thing}"
			while true
			do
				ping -c 10 "${thing}" >/dev/null 2>&1
				if [[ $? -eq 0 ]]
				then
					printf '.'
					sleep 1
				else
					printf " - %s is gone.\n" "${thing}"
					break
				fi
			done
		fi
		if [[ "${method}" = 'tcp' && "${waitfor}" = 'appeared' ]]
		then
			printf "Waiting for %s port %s TCP to be reachable." "${thing}" "${port}"
			while true
			do
				timeout 5 bash -c "exec 8<>/dev/tcp/${thing}/${port}" >/dev/null 2>&1
				if [[ $? -ne 0 ]]
				then
					printf '.'
					sleep 1
				else
					printf " - %s has appeared.\n" "${thing}"
					break
				fi
			done
		elif [[ "${method}" = 'tcp' && "${waitfor}" = 'gone' ]]
		then
			printf "Waiting for %s port %s TCP to be gone." "${thing}" "${port}"
			while true
			do
				timeout 5 bash -c "exec 8<>/dev/tcp/${thing}/${port}" >/dev/null 2>&1
				if [[ $? -eq 0 ]]
				then
					printf '.'
					sleep 1
				else
					printf " - %s is gone.\n" "${thing}"
					break
				fi
			done
		fi
	elif [[ "${type}" = 'file' && "${waitfor}" = 'appeared' ]]
	then
		printf "Waiting for file %s to appear." "${thing}"
		while true
		do
			if [[ ! -e "${thing}" ]]
			then
				printf '.'
				sleep 1
			else
				printf " - %s has appeared.\n" "${thing}"
				break
			fi
		done
	elif [[ "${type}" = 'file' && "${waitfor}" = 'gone' ]]
	then
		printf "Waiting for file %s to be gone." "${thing}"
		while true
		do
			if [[ -e "${thing}" ]]
			then
				printf '.'
				sleep 1
			else
				printf " - %s is gone.\n" "${thing}"
				break
			fi
		done
	else
		"${FUNCNAME[0]}" -?
	fi
}

# vim: filetype=sh
