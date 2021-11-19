export RESTIC_PASSWORD_FILE=~/.restic-password
export RESTIC_REPOSITORY=/media/${LOGNAME}/Backup/restic-repo/
alias restic-backup='nice -n 10 restic backup ~ /var/www/'
alias restic-forget='restic forget --keep-last 3 --prune'
alias restic-mount='restic mount ~/restic'
alias restic-snapshots='restic snapshots'

function restic-age() {
        local time="$(restic snapshots --json | jq -r '.[] | .time + " " + .id' | sort | tail -1 | cut -d' ' -f 1 | xargs -n 1 date +%s -d)"
        local now="$(date +%s)"
        local age=$(( now - time ))
        echo $age
}
