#!/usr/bin/env bash

function cfgsync {
	GITCFG="$1"
	LOCCFG="$2"
	$DIFF --new-file "$GITCFG" "$LOCCFG" 
	if [[ $? -eq 0 ]]
	then
		echo "$GITCFG -> $LOCCFG: Nothing to do."
	else
		read -p "Accept $LOCCFG Y/N? " -r
		if [[ $REPLY =~ ^[Yy] ]]
		then
			install -b "$GITCFG" "$LOCCFG"
			echo "$GITCFG -> $LOCCFG: Updated."
		fi
	fi
}

DIFF=colordiff
which $DIFF >/dev/null || DIFF=diff
cd $(dirname $0)

cfgsync Vim/vimrc "$HOME/.vimrc"
test -d "$HOME/.bashrc.d/" || mkdir "$HOME/.bashrc.d/"
for FILE in $(ls Bash/bashrc.d/*bash); do
	cfgsync "$FILE" "$HOME/.bashrc.d/$(basename $FILE)"
done

case $(uname -s) in
	"Darwin"|"Linux"|"FreeBSD")
		echo "Platform is Darwin, Linux or FreeBSD"
		;;
	"CYGWIN_NT-10.0")
		echo "Platform is Cygwin"
		cfgsync Vim/vimrc "$USERPROFILE/_vimrc"
		cfgsync Vim/gvimrc "$USERPROFILE/_gvimrc"
		cfgsync Terminals/minttyrc "$HOME/.minttyrc"
		cfgsync Cygwin/bashrc "$HOME/.bashrc"
		test -d "$HOME/bin" || mkdir "$HOME/bin"
		cfgsync Cygwin/ssh-agent-bootstrap "$HOME/bin/ssh-agent-bootstrap"
		;;
esac
