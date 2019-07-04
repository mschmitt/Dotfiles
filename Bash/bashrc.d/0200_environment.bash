# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

# Commonly used environment variables
export SHELLCHECK_OPTS='--exclude=SC2034'
export SVN_EDITOR=vim
if [[ "$TERM" == "screen" ]]
then
	export TMOUT=0
else
	export TMOUT=3600
fi
export NMON=cnd
export LANG=en_US.utf-8

# Use Cygwin SSH for Git when in Cygwin shell
if [[ "$UNAME_S" == "CYGWIN_NT-10.0" ]]
then
        export GIT_SSH=/usr/bin/ssh
fi


# vim: filetype=sh
