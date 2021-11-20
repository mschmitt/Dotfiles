#!/bin/bash

# Pathogen
if [[ -v USERPROFILE ]]
then
	winprofile="$(cygpath "${USERPROFILE}")"
	printf "Pathogen -> %s\n" "${winprofile}"
	# running on Windows, prepare for gvim
	mkdir -p ${winprofile}/vimfiles/autoload ${winprofile}/vimfiles/bundle && \
	curl -LSso ${winprofile}/vimfiles/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi
printf "Pathogen -> %s\n" "~/.vim/bundle"
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

plugins=(
	'https://github.com/w0rp/ale'
	'https://github.com/itchyny/lightline.vim'
	'https://github.com/vimoutliner/vimoutliner'
	'https://github.com/yggdroot/indentline'
	'https://github.com/pedrohdz/vim-yaml-folds'
)

function git_clone_or_pull() {
	local url="${1}"
	local basename="$(basename "${url}")"
	if [[ -d "${basename}/.git" ]]
	then
		cd "${basename}"
		git pull
		return $?
	else
		git clone "${url}"
		return $?
	fi
}


for plugin in "${plugins[@]}"
do
	if [[ -v USERPROFILE ]]
	then
		printf "%s -> %s\n" "${plugin}" "${winprofile}/vimfiles/bundle/"
		cd ${winprofile}/vimfiles/bundle/
		git_clone_or_pull "${plugin}"
	fi
	printf "%s -> %s\n" "${plugin}" "~/.vim/bundle/"
	cd ~/.vim/bundle
	git_clone_or_pull "${plugin}"
done
