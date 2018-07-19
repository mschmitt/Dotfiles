# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

set -o vi
HISTSIZE=100000
HISTCONTROL=ignoreboth
HISTTIMEFORMAT="%Y%m%d %H%M%S "

# vim: filetype=sh
