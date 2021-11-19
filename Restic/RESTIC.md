# Restic notes

## Repository definition

```
export RESTIC_REPOSITORY=/media/${LOGNAME}/Backup/restic-repo/
export RESTIC_REPOSITORY=sftp:backupserver:/export/foo/restic-repo/
etc.
```

## Password generation

```
export RESTIC_PASSWORD_FILE=~/.restic-password
openssl rand -hex 32 > "${RESTIC_PASSWORD_FILE}"
gpg --encrypt --armor --default-recipient-self "${RESTIC_PASSWORD_FILE}"
```

I tend to keep the password file live in the home directory (file system itself
must be encrypted) and to keep the encrypted password backup on the same media
as the repository. I also prefer the backup media to be unencrypted.

## Repository initialization

With the environment variables from above set:

```
restic init
```

## Aliases and function

* restic-backup backs up, no questions asked
* restic-forget forgets and prunes all but the 3 previous snapshots
* restic-mount mounts the backup on ~/restic
* restic-snapshots lists all backed-up snapshots fyi
* restic-age shows seconds since last backup

## Panic

* Find the encrypted password file and decrypt to ~/.restic-password
* Set environment variables for password and repository
* restic mount ~/restic
