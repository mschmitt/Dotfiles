# Some basic alias definitions that I use everywhere
alias gpgcat='gpg -o-'
alias gpg="LANG=en_US gpg"
alias vi=vim
alias wget-mirror='wget --tries=20 --mirror --retry-connrefused --no-parent --waitretry=300'

if [[ "$(uname -s)" == "Darwin" ]]
then
	alias lsusb='system_profiler SPUSBDataType'
	alias locate='mdfind -name'
	alias ls='ls -G'
elif [[ "$(uname -s)" == "FreeBSD" ]]
then
	alias ls='ls -G'
elif  [[ "$(uname -s)" == "Linux" || "$(uname -s)" == "CYGWIN_NT-10.0" ]]
then
	alias ls='ls --color=auto'
fi

if [[ "$(uname -s)" == "CYGWIN_NT-10.0" ]]
then
	alias ping6='ping /6'
fi


# vim: filetype=sh
