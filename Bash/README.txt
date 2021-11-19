[[ "$-" =~ i ]] && for FILE in $(ls ~/.bashrc.d/*bash); do source $FILE; done
