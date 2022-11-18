# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

# Commonly used environment variables
export SHELLCHECK_OPTS='--exclude=SC2034'
export SVN_EDITOR=vim
export GIT_EDITOR=vim
export EDITOR=vim
[[ "$UNAME_S" == "Linux" ]] && export LVM_SUPPRESS_FD_WARNINGS=1

if [[ "$TERM" == "screen" ]] 
then
	export TMOUT=0
elif [[ -v VSCODE_SHELL_INTEGRATION ]]
then
	export TMOUT=0
else
	export TMOUT=3600
fi
export NMON=cnd
export LANG=en_US.utf-8

# Use Cygwin SSH for Git when in Cygwin shell
if [[ "$UNAME_S" =~ CYGWIN_NT ]]
then
        export GIT_SSH=/usr/bin/ssh
fi

# Prefer snap versions of software only if I'm not root
if [[ -d /snap/bin && $UID -ne 0 ]]
then
	export PATH=/snap/bin:$PATH
fi

# Finally prepend bin in home
export PATH=$HOME/bin:$PATH

# vim: filetype=sh
