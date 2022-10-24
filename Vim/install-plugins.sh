#!/usr/bin/env bash

if ! type curl
then
	printf "curl is required.\n"
fi

# Pathogen
if [[ -v USERPROFILE ]]
then
	# running on Windows, prepare for gvim
	winprofile="$(cygpath "${USERPROFILE}")"
	printf "Pathogen -> %s\n" "${winprofile}"
	mkdir -p ${winprofile}/vimfiles/autoload ${winprofile}/vimfiles/bundle && \
	curl -LSs https://tpo.pe/pathogen.vim > ${winprofile}/vimfiles/autoload/pathogen.vim 
fi
printf "Pathogen -> %s\n" "${HOME}"
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSs https://tpo.pe/pathogen.vim > ~/.vim/autoload/pathogen.vim 

plugins=(
	'https://github.com/w0rp/ale'
	'https://github.com/itchyny/lightline.vim'
	'https://github.com/vimoutliner/vimoutliner'
	'https://github.com/yggdroot/indentline'
	'https://github.com/pedrohdz/vim-yaml-folds'
	'https://github.com/tpope/vim-vinegar'
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
