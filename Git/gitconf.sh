#!/usr/bin/env bash
type git 2>/dev/null|| exit
git config --global push.default simple
git config --global help.autocorrect 20
git config --global log.abbrevcommit true
git config --global commit.verbose true
git config --global alias.log-full "log --stat --graph"
git config --global alias.log-oneline "log --pretty=oneline"
git config --global pull.rebase false
git config --global alias.tags-fix "! git tag -l | xargs git tag -d; git pull --tags"
git config --global alias.tags-push "push --tags"
git config --global alias.dirdiff "difftool --dir-diff --no-symlinks"
git config --global alias.atag "tag --annotate --message ''"
git config --global alias.tpush "push --follow-tags"

if type bcompare 2>/dev/null
then
	git config --global diff.tool bcompare
	git config --global difftool.bcompare.trustExitCode true
	git config --global difftool.prompt false
	git config --global merge.tool bcompare
	git config --global mergetool.bcompare.trustExitCode true
	git config --global mergetool.prompt false

fi
