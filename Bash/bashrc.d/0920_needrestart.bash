if [[ -t 0 && -f /var/run/reboot-required ]]
then
	echo "Reboot required."
fi
