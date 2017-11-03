#!/usr/bin/env bash

function cfgsync {
	GITCFG="$1"
	LOCCFG="$2"
	$DIFF --new-file "$GITCFG" "$LOCCFG" 
	if [[ $? -eq 0 ]]
	then
		echo "$GITCFG: Nothing to do."
		exit 0
	fi
	read -p "Accept Y/N? " -r
	if [[ $REPLY =~ ^[Yy] ]]
	then
		install -b "$GITCFG" "$LOCCFG"
		echo "$GITCFG: Updated."
	fi
}

DIFF=colordiff
which $DIFF >/dev/null || DIFF=diff

case $(uname -s) in
	"Darwin"|"Linux"|"FreeBSD")
		cfgsync Vim/vimrc "$HOME/.vimrc"
		;;
esac
