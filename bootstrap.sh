#!/usr/bin/env bash

if [[ "${LOGNAME}" != 'codespace' ]]
then
	echo "This is a bootstrap script for github codespaces."
	echo "https://docs.github.com/en/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#dotfiles"
	exit 1
fi

sudo locale-gen de_DE.utf8

sudo apt-get -y update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
curl -s https://raw.githubusercontent.com/mschmitt/Dotfiles/master/Misc/yolo.sh | bash || true

touch  ~/.dotfiles-nohelp
