" Recommended reading:
"
" https://sanctum.geek.nz/arabesque/gracefully-degrading-vimrc/
" http://vimhelp.appspot.com/
" http://vim.wikia.com/wiki/Modeline_magic

" Name dieser Datei:
"
" ~/.vimrc		(UNIX)
" %userprofile%\_vimrc  (Windows)

" From MacOS:
set nocompatible		" Use Vim defaults instead of 100% vi compatibility
set backspace=2			" same as ":set backspace=indent,eol,start"

" Also from MacOS:
" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
au BufWrite /tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup

set ruler			" Always show coordinates

set autoindent            

set ignorecase             	" Ignore case when searching

syntax on			" Enable syntax highlighting

filetype plugin indent on  	" http://vimdoc.sourceforge.net/htmldoc/filetype.html
"let perl_fold=1            	" Activate autofolding in the Perl ftplugin
"let perl_fold_blocks=1

set hlsearch               	" Typ :nohls to un-higlight

set showmode 			" anzeige INSERT/REPLACE/...

set shiftwidth=8 		" Number of spaces to use for each step of (auto)indent.
set tabstop=8			" Number of spaces that a <Tab> in the file counts for.

set modeline			" Vim default: on (off for root)
set modelines=5			" number of lines that is checked for set commands.

let g:GPGPreferArmor=1 		" gnupg.vim

" Fail silently if pathogen not installed
silent! execute pathogen#infect() 

" ALE
let g:ale_sign_column_always = 1

" GUI settings
if has('osx')
	set guifont=Monaco:h14
endif
set guioptions=Tr		" (T) Toolbar on, (r) scrollbar always on
