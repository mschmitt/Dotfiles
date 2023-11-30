#!/usr/bin/env bash
set -o errexit

function errorexit() {
	trap - ERR
	printf "Error on line %s\n" "$(caller)"
	exit 1
}
trap errorexit ERR

sudo apt-get -y install curl git make shellcheck vim-nox ansible jq locate apt-file

cd $HOME

git clone https://github.com/mschmitt/Dotfiles
cd Dotfiles
git remote set-url        origin https://github.com/mschmitt/Dotfiles
git remote set-url --push origin git@github.com:mschmitt/Dotfiles
make

cat >> $HOME/.bashrc << 'Here'
# Setup bash environment only if running as an interactive shell
[[ "$-" =~ i ]] && for FILE in $(ls ~/.bashrc.d/*bash); do source $FILE; done
Here
