#!/bin/sh

inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
if [ "$inside_git_repo" ]; then

    CHANGED="$(git status --porcelain)"
    if [ -z "${CHANGED}" ]; then
        echo "Branch is clean.";
    else
        echo "Branch is not clean.";
    fi
else
    echo "Git repo not found.";
fi