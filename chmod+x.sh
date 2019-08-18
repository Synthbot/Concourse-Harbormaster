#!/bin/bash
# Author: Synthbot
# Github: https://github.com/Synthbot
# ---
# Built to elimate the pain of adding multiple shell scripts to git, only to find out concourse can't run them.
set -e

git ls-files "*.sh" | xargs dos2unix | git add --chmod=+x "*.sh"
git status