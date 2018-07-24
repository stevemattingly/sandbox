#!/bin/bash

# Part 1. If git has not already been configured, do it now.
if ! grep --quiet github ~/.gitconfig; then
    git config --global user.name "${C9_FULLNAME}"
    git config --global user.email $C9_EMAIL
    git config --global credential.helper 'cache --timeout 5400'
    git config --global core.editor '/mnt/shared/sbin/c9 open --wait'
    git config --global credential.https://github.com.username $C9_EMAIL
fi

# Part 2. Commit changes and sync with GitHub.

# This part begins by retrieving all changes to "submodules" from GitHub.
# Submodules are repos within repos. Within repos for student assignments,
# they are used to incorporate various utilities that are re-used across
# many different assignments.

# Next, this script adds all new or modified files in your "working tree"
# to the index or "staging area" of your git repository in c9.

# If anything was added, this script opens a tab for you to edit 
# a commit message for the logs, and pauses until you close the tab.

# If you saved before closing the tab, this script commits the staged 
# files to your c9 repository. (Closing the tab without saving will
# cancel the commit.)

# If the commit succeeds, this script syncs your c9 repository with
# its clone on GitHub.com. You may be asked to enter your GitHub password.
# The sync has two steps. First, this script pulls any changes on GitHub to 
# your c9 repo. If there are changes, you must edit another commit message 
# so that they can be merged into your c9 repository. Then this script pushes 
# changes from your c9 repository to GitHub.

cd . #.

git submodule update --remote --quiet

git add --all

#git commit --quiet -m 'Updates via sync script'

git pull --no-edit --quiet 

git push --quiet

git status
echo $?
if [ $? -eq 1 ]
then
   echo "blah blah blah"
fi