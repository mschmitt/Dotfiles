#!/usr/bin/env bash

function cfgsync {
	GITCFG="$1"
	LOCCFG="$2"
	$DIFF --new-file "$GITCFG" "$LOCCFG" 
	if [[ $? -eq 0 ]]
	then
		echo "$GITCFG: Nothing to do."
	else
		read -p "Accept Y/N? " -r
		if [[ $REPLY =~ ^[Yy] ]]
		then
			install -b "$GITCFG" "$LOCCFG"
			echo "$GITCFG: Updated."
		fi
	fi
}

DIFF=colordiff
which $DIFF >/dev/null || DIFF=diff
cd $(dirname $0)
case $(uname -s) in
	"Darwin"|"Linux"|"FreeBSD")
		echo "Platform is Darwin, Linux or FreeBSD"
		cfgsync Vim/vimrc "$HOME/.vimrc"
		;;
	"CYGWIN_NT-10.0")
		echo "Platform is Cygwin"
		cfgsync Vim/vimrc "$HOME/.vimrc"
		cfgsync Vim/vimrc "$USERPROFILE/_vimrc"
		cfgsync Terminals/minttyrc "$HOME/.minttyrc"
		;;
esac
