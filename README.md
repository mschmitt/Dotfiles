# Dotfiles

I learned UNIX in them 1990s on AIX 3 and SINIX-Z, and I still try to stick 
with as vanilla an environment as possible, because I never know over what 
kind of machine I'm going find myself parachuting next.

Nevertheless, I somewhat appreciate the following things:

* vim Syntax Highlighting 
* white terminal background
* super clean SSH agent environment

## /Vim: Vim settings

Just a few defaults, including GUI settings and the occasional plugin I use
here and there. No advanced development environment magic. Sorry.

I'm not quite sure what's the deal with all those vim package managers, but 
I do use pathogen: https://github.com/tpope/vim-pathogen

## /Cygwin: Bash settings on Cygwin

On Windows Cygwin, I bootstrap an ssh-agent within .bashrc, because that 
is how I roll.

## /Terminals: Terminal configs

These are mostly color settings with the notable exception of minttyrc which
contains a few additional settings for the Cygwin terminal.

Colors are based on the xresource defaults for xterm, with the lighter ones 
tuned a bit darker, similar to the defaults on macOS's Terminal.app.

Merging putty colors into existing sessions is best done with putty session 
manager https://sourceforge.net/projects/puttysm/ or creative copying and 
editing of the REG file.
