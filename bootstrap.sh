#!/usr/bin/env bash

sudo locale-gen de_DE.utf8

sudo apt-get -y update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
curl -s https://raw.githubusercontent.com/mschmitt/Dotfiles/master/Misc/yolo.sh | bash || true

touch  ~/.dotfiles-nohelp
