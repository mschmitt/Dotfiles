#!/usr/bin/env bash
type git 2>/dev/null|| exit
git config --global push.default simple
git config --global help.autocorrect 20

if type bcompare 2>/dev/null
then
	git config --global diff.tool bc3
	git config --global difftool.bc3.trustExitCode true
	git config --global difftool.prompt false
	git config --global merge.tool bc3
	git config --global mergetool.bc3.trustExitCode true
	git config --global mergetool.prompt false
fi
