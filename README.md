# Dotfiles

I learned UNIX in them 1990s on AIX 3 and SINIX-Z, and I still try to stick
with as vanilla an environment as possible, because I never know over what
kind of machine I'm going find myself parachuting next.

Nevertheless, I somewhat appreciate the following things:

* vim Syntax Highlighting
* white terminal background
* super clean SSH agent environment

This dotfiles repository does not work directly on the managed files, but I
use an unbelievably awkward script "deploy.sh" that merges the repository
onto the actual dotfiles.

## /Bash: Bash settings

Needs the following line in .bashrc to actually be activated:

```
# Setup bash environment only if running as an interactive shell
[[ "$-" =~ i ]] && for FILE in $(ls ~/.bashrc.d/*bash); do source $FILE; done
```

Notable things here:

* My vastly overengineered "waitfor" function in 0605_waitfor.bash, which goes
  well with the "poke" alias from 0600_functions.bash that pushes arbitrary
  events to Telegram.
* 0610_edfn.bash is a dialog-based editor for filenames.
* 0800_ssh-agent.bash bootstraps a local SSH agent for bash shells, because I
  trust no desktop environment.

## /Cygwin: Bash settings on Cygwin

This is a top-level .bashrc I use on Cygwin.

## /Vim: Vim settings

Improved defaults, including GUI settings and the plugins I use:

* ALE advanced linting engine
* Lightline
* Outliner
* Indentline (for YAML)
* YAML folds

I use pathogen for vim plugin management: https://github.com/tpope/vim-pathogen

## /Terminals: Terminal configs

These are mostly color settings with the notable exception of minttyrc which
contains a few additional settings for the Cygwin terminal.

Colors are based on the xresource defaults for xterm, with the lighter ones
tuned a bit darker, similar to the defaults on macOS's Terminal.app.

Merging putty colors into existing sessions is best done with putty session
manager https://sourceforge.net/projects/puttysm/ or creative copying and
editing of the REG file.

That one site (note to self) about terminal colors is: https://terminal.sexy/

## /Screen: screenrc

Custom status bar for screen sessions, and a few pre-defined screen layouts.

Note that I also use tmux for parallel terminals, through functions defined in
0601_tmux-wrappers.bash in the /Bash department.

## /Git: Git global defaults

Mostly configuration of git autocorrect and diff-/mergetool

## /Restic: Restic notes

Just some notes on how to use and additional .bashrc lines to bootstrap restic.
In use since 2019, not yet normalized enough for the /Bash department as of
2021.

[modeline]: # " vim: set fenc=utf-8 textwidth=78 formatoptions=tn: "
