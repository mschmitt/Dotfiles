# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

function tmux_vmail() {
	tmux new-session -d 'ssh vmx1 -l root -A'
	tmux split-window 'ssh vmx2 -l root -A'
	tmux split-window 'ssh vmail -l root -A'
	tmux set-option -g synchronize-panes on
	tmux set-option -g allow-rename off 
	tmux select-layout even-vertical
	tmux rename-window 'vmx1/vmx2/vmail'
	tmux attach-session
}

# vim: filetype=sh
