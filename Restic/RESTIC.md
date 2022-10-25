# Restic notes

* This is public but still not thoroughly integration tested.
* Big TODO: Make usable on zsh

## Bootstrap file

```
install -D bootstrap.bash ~/.restic/bootstrap
echo '. ~/.restic/bootstrap' >> ~/.bashrc
```

## Repository definition goes to ~/.restic/repo-location

```
/media/${LOGNAME}/Backup/restic-repo/
sftp:backupserver:/export/foo/restic-repo/
etc. (only one definition in this file)
```

## Password goes to ~/.restic/repo-password

```
RESTIC_PASSWORD_FILE=~/.restic/repo-password
openssl rand -hex 32 > "${RESTIC_PASSWORD_FILE}"
gpg --encrypt --armor --default-recipient-self "${RESTIC_PASSWORD_FILE}"
```

I tend to keep the password file live in the home directory (file system itself
should be encrypted) and to keep the encrypted password backup on the same media
as the repository. I also prefer the backup media to be unencrypted.

## Repository initialization

```
. ~/.restic/bootstrap
restic init
```

## Functions

* restic-backup backs up, no questions asked
* restic-forget forgets and prunes all but the 3 previous snapshots
* restic-mount mounts the backup on ~/.restic/mnt
* restic-umount umounts the backup from ~/restic/mnt if things went wrong
* restic-snapshots lists all backed-up snapshots fyi
* restic-age shows seconds since last backup

## systemd

```
install -D systemd-user/restic* ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now restic.timer
```

## Panic

* Find the encrypted password file and decrypt to ~/.restic/password
* Set environment variables for password and repository
* restic mount ~/.restic/mnt
