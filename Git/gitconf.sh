#!/bin/bash
type git 2>/dev/null|| exit
git config --global push.default simple
git config --global help.autocorrect 20
