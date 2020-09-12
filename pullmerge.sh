#!/bin/sh

inside_git_repo=$(git rev-parse --is-inside-work-tree 2>/dev/null)
if [ "$inside_git_repo" ]; then
    echo "Inside git repo."
    CHANGED=$(git --work-tree=${WORKTREE} status --porcelain)
    if [ -n "${CHANGED}" ]; then
    echo "Branch is not clean."
    else
        echo "Branch is clean."
else
    echo "Git repo not found."
fi