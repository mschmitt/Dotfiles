# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

if [ -z "${BASH_COMPLETION_VERSINFO-}" ]
then
	source /etc/bash_completion
fi

# vim: filetype=sh
