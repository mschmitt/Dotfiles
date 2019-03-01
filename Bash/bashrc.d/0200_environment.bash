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
# vim: filetype=sh
