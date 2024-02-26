# Skip if running non-interactively
if [[ ! -t 0 ]]
then
	return
fi

# Point out generally useful stuff that is missing on this system.
if [[ ! -z "$debian" && ! -e ~/.dotfiles-nohelp ]]
then
	[[ -x $(command -v locate) ]]   || echo "locate is missing here."
	[[ -x $(command -v tuptime) ]]  || echo "tuptime is missing here."
	[[ -x $(command -v apt-file) ]] || echo "apt-file is missing here."
	[[ -x $(command -v sar) ]]      || echo "sysstat is missing here."
	grep -q 'ENABLED="true"' /etc/default/sysstat 2>/dev/null || echo "sadc is disabled here."
fi

# vim: filetype=sh
