#!/usr/bin/env bash

[[ ${EUID} -eq 0 ]] || exec sudo "${0}"
snap install bitwarden
snap install authy
snap install telegram-desktop
snap install spotify
