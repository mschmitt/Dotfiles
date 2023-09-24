if [[ "$UNAME_S" == "Linux" && -e /etc/debian_version ]]
then
	read -r debian < /etc/debian_version
fi

# vim: filetype=sh
