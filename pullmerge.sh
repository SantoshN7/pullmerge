#!/bin/sh

inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
if [ "$inside_git_repo" ]; then #checks if inside git repo

    is_git_repo_clean="$(git status --porcelain)"
    if [ -z "${is_git_repo_clean}" ]; then #checks if branch is clean

        origin="$1"
        branch="$(git rev-parse --verify $origin 2>/dev/null)"
        if [[ -n $branch ]]; then #checks if valid origin

            current_branch="$(git symbolic-ref --short -q HEAD)"
            if [ "$origin" = "$current_branch" ]; then #checks if on orign or branch
                #if on origin
                git pull origin "$origin";
            else
                #if on branch
                git checkout "$origin";
                git pull origin "$origin";
                git checkout "$current_branch";
                git merge "$origin";
            fi
        else 
            echo "Provide origin name as an argument"
        fi
    else
        echo "Branch is not clean.";
    fi
else
    echo "Git repo not found.";
fi