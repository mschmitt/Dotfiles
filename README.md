# Dotfiles

I learned UNIX in them 1990s on AIX 3 and SINIX-Z, and I still try to stick 
with as vanilla an environment as possible, because I never know over what 
kind of machine I'm going find myself parachuting next.

Nevertheless, I somewhat appreciate the following things:

* vim Syntax Highlighting 
* white terminal background
* super clean SSH agent environment

## Vim settings

Just a few defaults, including GUI fonts and the occasional plugin I use
here and there. No advanced development things are going on here. 

## Bash settings on Cygwin

I bootstrap an ssh-agent within .bashrc, because that's how I roll.

## Terminal configs

These are mostly color settings with the notable exception of minttyrc which
has a few more settings in the config.

Merging down putty colors into existing sessions is best done with putty
session manager or creative copying and editing of the REG file.
