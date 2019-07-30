# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

alias emacs=vi
alias joe='echo "core dumped." #'
alias nano='echo "core dumped." #'

# vim: filetype=sh
