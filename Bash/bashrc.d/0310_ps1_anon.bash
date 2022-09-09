# Anonymize bash prompt for screenshots and pastes
function ps1_anon (){
	if [[ -v SAVED_PS1 ]] 
	then
		PS1="${SAVED_PS1}" 
		unset SAVED_PS1 
	else
		SAVED_PS1="${PS1}" 
		PS1='\$ '
	fi
}
