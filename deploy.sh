#!/usr/bin/env bash

function cfgsync {
	GITCFG="$1"
	LOCCFG="$2"
	$DIFF --new-file "$LOCCFG" "$GITCFG"
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
type $DIFF 2>/dev/null || DIFF=diff
cd $(dirname $0)

test -d "$HOME/.bashrc.d/" || mkdir "$HOME/.bashrc.d/"
for FILE in $(ls Bash/bashrc.d/*bash); do
	cfgsync "$FILE" "$HOME/.bashrc.d/$(basename $FILE)"
done

cfgsync Vim/vimrc "$HOME/.vimrc"
test -d "$HOME/.vim/skeleton" || mkdir "$HOME/.vim/skeleton/"
for FILE in $(ls Vim/skeleton/*); do
	cfgsync "$FILE" "$HOME/.vim/skeleton/$(basename $FILE)"
done

bash Git/gitconf.sh

cfgsync Screen/screenrc "$HOME/.screenrc"

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
