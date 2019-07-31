# Skip if running non-interactively
if [[ ! -t 0 ]]
then
        return
fi

alias joe='echo "core dumped." #'
alias nano='echo "core dumped." #'
alias pico='echo "core dumped." #'
alias mcedit='echo "core dumped." #'
alias emacs='ed'

# vim: filetype=sh
