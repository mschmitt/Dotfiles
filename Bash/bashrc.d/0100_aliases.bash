# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

# Some basic alias definitions that I use everywhere
alias gpgcat='gpg -o-'
alias gpg="LANG=en_US gpg"
alias vi=vim
alias wget-mirror='wget --tries=20 --mirror --retry-connrefused --no-parent --waitretry=300 -e robots=off'
alias mc='mc --nomouse --no-x11 --stickchars --nocolor'
alias tohtml='vim -c TOhtml -c w -c qa'
alias vinix='sudoedit /etc/nixos/configuration.nix'
alias renix='sudo nice ionice nixos-rebuild'

if [[ "$UNAME_S" == "Darwin" ]]
then
	alias lsusb='system_profiler SPUSBDataType'
	alias locate='mdfind -name'
	alias ls='ls -G'
	alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport'
elif [[ "$UNAME_S" == "FreeBSD" ]]
then
	alias ls='ls -G'
elif  [[ "$UNAME_S" == "Linux" || "$UNAME_S" =~ CYGWIN_NT ]]
then
	alias ls='ls --color=auto'
	[[ -d /etc/nixos ]] || alias top='top -c'
fi

if [[ "$UNAME_S" =~ CYGWIN_NT ]]
then
	alias ping6='ping /6'
fi

if [[ -x $(command -v getcap) && -x $(command -v nmap) ]]
then
	if getcap "$(command -v nmap)" | grep -q cap_net_raw
	then
		alias nmap='nmap --privileged'
		export NMAP_PRIVILEGED=''
	fi
fi

if [[ "$UNAME_S" == "Linux" && "$(readlink -f /sbin/init)" =~ systemd ]]
then
	alias userctl='systemctl --user'
	complete -F _complete_alias userctl
fi

# vim: filetype=sh
