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
			install "$GITCFG" "$LOCCFG"
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

cfgsync Bash/Completion/bash_completion "$HOME/.bash_completion"

cfgsync Vim/vimrc "$HOME/.vimrc"
test -d "$HOME/.vim/"         || mkdir "$HOME/.vim/"
test -d "$HOME/.vim/skeleton" || mkdir "$HOME/.vim/skeleton/"
for FILE in $(ls Vim/skeleton/*); do
	cfgsync "$FILE" "$HOME/.vim/skeleton/$(basename $FILE)"
done

bash Git/gitconf.sh
test -d .git && install -v -m 700 Git/pre-commit .git/hooks/pre-commit

bash Gnome/gnomeconf.sh
[[ -e /etc/xdg/autostart/gnome-keyring-ssh.desktop ]] && install -D Gnome/gnome-keyring-ssh.desktop ~/.config/autostart/

bash Misc/ansible.sh

cfgsync Screen/screenrc "$HOME/.screenrc"
for I in 1 2 3 4 5 6 7 8 9 
do
	cfgsync Screen/screen.${I}-pane.layout "$HOME/.screen.${I}-pane.layout"
done

case $(uname -s) in
	"Darwin"|"Linux"|"FreeBSD")
		echo "Platform is Darwin, Linux or FreeBSD"
		;;
	"CYGWIN_NT-10.0")
		echo "Platform is Cygwin"
		cfgsync Vim/vimrc "$USERPROFILE/_vimrc"
		cfgsync Vim/vimrc "$USERPROFILE/_gvimrc"
		cfgsync Terminals/minttyrc "$HOME/.minttyrc"
		cfgsync Cygwin/bashrc "$HOME/.bashrc"
		;;
esac

STEAMROOT='/cygdrive/c/Program Files (x86)/Steam'
if [[ -d "$STEAMROOT" ]]
then
	readarray -t CFGDIRS < <(ls -d "$STEAMROOT"/userdata/*/730/local/cfg/)
	for CFGDIR in "${CFGDIRS[@]}"
	do
		cfgsync CSGO/autoexec.cfg           "${CFGDIR}autoexec.cfg"
		cfgsync CSGO/advertisecommunity.cfg "${CFGDIR}advertisecommunity.cfg"
		cfgsync CSGO/cleardecals.cfg        "${CFGDIR}cleardecals.cfg"
		cfgsync CSGO/jumpthrow.cfg          "${CFGDIR}jumpthrow.cfg"
		cfgsync CSGO/quickswitch.cfg        "${CFGDIR}quickswitch.cfg"
		cfgsync CSGO/radiobinds.cfg         "${CFGDIR}radiobinds.cfg"
		cfgsync CSGO/training.cfg           "${CFGDIR}training.cfg"
		cfgsync CSGO/trashtalk.cfg          "${CFGDIR}trashtalk.cfg"
	done 
fi

if [[ -s /etc/antix-version ]]
then

		cfgsync AntiX/roxterm.sourceforge.net/Profiles/Default ~/.config/roxterm.sourceforge.net/Profiles/Default
		cfgsync AntiX/roxterm.sourceforge.net/Global ~/.config/roxterm.sourceforge.net/Global
		cfgsync AntiX/IceWM/startup ~/.icewm/startup
		cfgsync AntiX/IceWM/personal ~/.icewm/personal
		cfgsync AntiX/IceWM/menu ~/.icewm/menu
		cfgsync AntiX/IceWM/toolbar ~/.icewm/toolbar
		cfgsync AntiX/IceWM/preferences ~/.icewm/preferences
		cfgsync AntiX/IceWM/theme ~/.icewm/theme
fi

if type ansible-playbook >/dev/null 2>&1
then
	ansible-playbook -i Cron/inventory Cron/crontab.yml
else
	echo 'Install ansible maybe?'
fi
