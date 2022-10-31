# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

function tmux_vmail() {
	tmux new-session -d 'ssh vmx1'
	tmux split-window 'ssh vmx2'
	tmux split-window 'ssh vmail'
	tmux set-option -g synchronize-panes on
	tmux set-option -g allow-rename off 
	tmux select-layout even-vertical
	tmux rename-window 'vmx1/vmx2/vmail'
	tmux attach-session
}

function tmux_vmx() {
	tmux new-session -d 'ssh vmx1'
	tmux split-window 'ssh vmx2'
	tmux set-option -g synchronize-panes on
	tmux set-option -g allow-rename off 
	tmux select-layout even-vertical
	tmux rename-window 'vmx1/vmx2'
	tmux attach-session
}

function tmux_netman() {
	tmux new-session -d 'ssh netman1'
	tmux split-window 'ssh netman2'
	tmux set-option -g synchronize-panes on
	tmux set-option -g allow-rename off 
	tmux select-layout even-vertical
	tmux rename-window 'netman1/netman2'
	tmux attach-session
}

function tmux_vpn() {
	tmux new-session -d 'ssh bravo'
	tmux split-window 'ssh oscar'
	tmux set-option -g synchronize-panes on
	tmux set-option -g allow-rename off 
	tmux select-layout even-vertical
	tmux rename-window 'bravo/oscar'
	tmux attach-session
}

function tmux_dohcluster() {
	tmux new-session -d 'ssh bravo -l root'
	tmux split-window 'ssh vweb3 -l root'
	tmux set-option -g synchronize-panes on
	tmux set-option -g allow-rename off 
	tmux select-layout even-vertical
	tmux rename-window 'bravo/vweb3'
	tmux attach-session
}

function tmux_freifunk() {
	tmux new-session -d 'ssh ff-bruecke'
	tmux split-window 'ssh ff-jungle'
	tmux set-option -g synchronize-panes on
	tmux set-option -g allow-rename off 
	tmux select-layout even-vertical
	tmux rename-window 'ff-bruecke/ff-jungle'
	tmux attach-session
}

# vim: filetype=sh
