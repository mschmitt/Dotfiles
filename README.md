# Dotfiles

I learned UNIX in them 1990s on AIX 3 and SINIX-Z, and I still try to stick 
with as vanilla an environment as possible, because I never know over what 
kind of machine I'm going find myself parachuting next.

Nevertheless, I somewhat appreciate the following things:

* vim Syntax Highlighting 
* white terminal background
* super clean SSH agent environment

## /Bash: Bash settings

I don't know yet whether it's a good idea to harmonize bash config at all. 
Needs the following line in .bashrc to actually be activated: 

```
for FILE in $(ls ~/.bashrc.d/*bash); do source $FILE; done
```

## /Cygwin: Bash settings on Cygwin

On Windows Cygwin, I bootstrap an ssh-agent within .bashrc, because that 
is how I roll.

## /Vim: Vim settings

Just a few defaults, including GUI settings and the occasional plugin I use
here and there. No advanced development environment magic. Sorry.

The Asynchronous Linting Engine for vim >= 8 looks nice and I'm currently
figuring out whether I have any use for it: https://github.com/w0rp/ale

I'm not quite sure what's the deal with all those vim package managers, but 
I do use pathogen: https://github.com/tpope/vim-pathogen

## /Terminals: Terminal configs

These are mostly color settings with the notable exception of minttyrc which
contains a few additional settings for the Cygwin terminal.

Colors are based on the xresource defaults for xterm, with the lighter ones 
tuned a bit darker, similar to the defaults on macOS's Terminal.app.

Merging putty colors into existing sessions is best done with putty session 
manager https://sourceforge.net/projects/puttysm/ or creative copying and 
editing of the REG file.

## /Screen: screenrc

Just a basic status bar for screen sessions.

## /Git: Git global defaults

Mostly configuration of git autocorrect and diff-/mergetool

# Vim install notes

## pathogen

```
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
```

## ale 

```
git clone https://github.com/w0rp/ale.git ~/.vim/bundle/ale
```

## lightline.vim

```
git clone https://github.com/itchyny/lightline.vim ~/.vim/bundle/lightline.vim
```

## vim outliner

```
git clone https://github.com/vimoutliner/vimoutliner ~/.vim/bundle/vimoutliner
```

[modeline]: # ( vim: set fenc=utf-8 textwidth=78 formatoptions=tan: ) 
