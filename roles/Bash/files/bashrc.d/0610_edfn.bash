# An interactive file renaming function, yep.

function edfn() {
	local oldname="$1"
	local newname
	local width=$((COLUMNS * 10 / 8 ))
	local height=$((LINES / 2 ))
	local tmpfile_newname="$(mktemp)"
	while true
	do
		dialog --title "Edit filename" --inputbox -- "${oldname}" ${height} ${width} "${oldname}" 2> "${tmpfile_newname}"
		if [[ $? -eq 0 ]]
		then
			break
		else
			rm "${tmpfile_newname}"
			clear
			return
		fi
	done
	read -r newname < "${tmpfile_newname}"
	rm "${tmpfile_newname}"

	if [[ "${oldname}" = "${newname}" ]]
	then
		dialog --title "No change" --msgbox "Filename unchanged." 10 30
		clear
		return
	fi

	dialog --title "Confirm Rename" --yesno -- "Rename\n$oldname\n\nTo\n$newname" ${height} ${width}
	if [[ $? -eq 0 ]]
	then
		clear
		mv --verbose --interactive -- "${oldname}" "${newname}"
		stat -- "${newname}"
	fi
}

# vim: filetype=sh
