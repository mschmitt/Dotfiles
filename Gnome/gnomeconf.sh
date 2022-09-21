#!/usr/bin/env bash
me_path="$(readlink -f "$0")"
me_dir="$(dirname "${me_path}")"
me_base="$(basename "${me_path}")"
install -D -m 0644 "${me_dir}"/gnome-keyring-ssh.desktop ~/.config/autostart/gnome-keyring-ssh.desktop

pkill -0 dbus-daemon -U "${LOGNAME}" || exit
gsettings set org.gnome.desktop.wm.preferences audible-bell false
gsettings set org.gnome.desktop.wm.preferences visual-bell true
gsettings set org.gnome.desktop.wm.preferences visual-bell-type frame-flash
gsettings set org.gnome.desktop.peripherals.touchpad click-method fingers
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false
gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+altgr-intl')]"
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:none']"
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Alt>x']"
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-format '24h'


