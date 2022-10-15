export RESTIC_REPOSITORY_FILE="${HOME}/.restic/repo-location"
export RESTIC_PASSWORD_FILE="${HOME}/.restic/password"
export RESTIC_INCLUDES="${HOME}"
export RESTIC_EXCLUDES="-e Sync -e Downloads"

# I have standardized on functions instead of aliases for everything,
# because restic-backup as an alias is not trivially usable from systemd
function restic-backup() {
	nice -n 10 restic backup ${RESTIC_EXCLUDES} ${RESTIC_INCLUDES}
}

function restic-forget() {
	restic forget --keep-last 3 --prune
}

function restic-umount() {
	fusermount -u ~/.restic/mnt
}

function restic-snapshots() {
	restic snapshots
}

function restic-mount() {
	mkdir -p ~/.restic/mnt
	ln -s -f mnt/snapshots/latest ~/.restic/latest
	restic mount ~/.restic/mnt
}

function restic-age() {
        local time="$(restic snapshots --json | jq -r '.[] | .time + " " + .id' | sort | tail -1 | cut -d' ' -f 1 | xargs -n 1 date +%s -d)"
        local now="$(date +%s)"
        local age=$(( now - time ))
        echo $age
}

# vim: filetype=bash
