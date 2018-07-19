# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

# Some basic alias definitions that I use everywhere
alias gpgcat='gpg -o-'
alias gpg="LANG=en_US gpg"
alias vi=vim
alias wget-mirror='wget --tries=20 --mirror --retry-connrefused --no-parent --waitretry=300'

if [[ "$UNAME_S" == "Darwin" ]]
then
	alias lsusb='system_profiler SPUSBDataType'
	alias locate='mdfind -name'
	alias ls='ls -G'
elif [[ "$UNAME_S" == "FreeBSD" ]]
then
	alias ls='ls -G'
elif  [[ "$UNAME_S" == "Linux" || "$UNAME_S" == "CYGWIN_NT-10.0" ]]
then
	alias ls='ls --color=auto'
fi

if [[ "$UNAME_S" == "CYGWIN_NT-10.0" ]]
then
	alias ping6='ping /6'
fi

# vim: filetype=sh
