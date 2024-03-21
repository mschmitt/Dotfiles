#!/usr/bin/env bash

if [[ ! -v GITHUB_CODESPACE_TOKEN ]]
then
	echo "This is a bootstrap script for github codespaces."
	echo "https://docs.github.com/en/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#dotfiles"
	exit 1
else
	sudo locale-gen de_DE.utf8
fi
