# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

function tmux_vmail() {
	tmux new-session -d 'ssh vmx1 -A'
	tmux split-window 'ssh vmx2 -A'
	tmux split-window 'ssh vmail -A'
	tmux set-option -g synchronize-panes on
	tmux set-option -g allow-rename off 
	tmux select-layout even-vertical
	tmux rename-window 'vmx1/vmx2/vmail'
	tmux attach-session
}

function tmux_vmx() {
	tmux new-session -d 'ssh vmx1 -A'
	tmux split-window 'ssh vmx2 -A'
	tmux set-option -g synchronize-panes on
	tmux set-option -g allow-rename off 
	tmux select-layout even-vertical
	tmux rename-window 'vmx1/vmx2'
	tmux attach-session
}

function tmux_vpn() {
	tmux new-session -d 'ssh bravo -l root -A'
	tmux split-window 'ssh oscar -l root -A'
	tmux split-window 'ssh yankee -l root -A'
	tmux set-option -g synchronize-panes on
	tmux set-option -g allow-rename off 
	tmux select-layout even-vertical
	tmux rename-window 'bravo/oscar/yankee'
	tmux attach-session
}

function tmux_dohcluster() {
	tmux new-session -d 'ssh bravo -l root -A'
	tmux split-window 'ssh vweb3 -l root -A'
	tmux set-option -g synchronize-panes on
	tmux set-option -g allow-rename off 
	tmux select-layout even-vertical
	tmux rename-window 'bravo/vweb3'
	tmux attach-session
}

function tmux_freifunk() {
	tmux new-session -d 'ssh ff-bruecke -A'
	tmux split-window 'ssh ff-jungle -A'
	tmux set-option -g synchronize-panes on
	tmux set-option -g allow-rename off 
	tmux select-layout even-vertical
	tmux rename-window 'ff-bruecke/ff-jungle'
	tmux attach-session
}

# vim: filetype=sh
