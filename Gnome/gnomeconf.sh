#!/usr/bin/env bash
pkill -0 dbus-daemon -U "${LOGNAME}" || exit
gsettings set org.gnome.desktop.wm.preferences audible-bell false
gsettings set org.gnome.desktop.wm.preferences visual-bell true
gsettings set org.gnome.desktop.wm.preferences visual-bell-type frame-flash
