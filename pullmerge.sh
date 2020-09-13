#!/bin/sh

inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
if [ "$inside_git_repo" ]; then

    is_git_repo_clean="$(git status --porcelain)"
    if [ -z "${is_git_repo_clean}" ]; then
        if [[ -n $1 ]]; then
            origin="$1"
            current_branch="$(git symbolic-ref --short -q HEAD)"
            if [ "$origin" = "$current_branch" ]; then
                git pull origin "$1";
            else
                echo "given branch not current";
            fi
        else 
            echo "Provide origin name as argument"
        fi
    else
        echo "Branch is not clean.";
    fi
else
    echo "Git repo not found.";
fi