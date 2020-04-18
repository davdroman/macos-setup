# Git

## Init

function gi
    curl -sL "https://www.gitignore.io/api/$argv" > .gitignore
    cat .gitignore
end

## Clone

function gcl -a ssh_name repo_ssh_address repo_name
    set ssh_path (ssh-path $ssh_name)
    test -n "$repo_name"; or set repo_name (basename $repo_ssh_address .git)

    env GIT_SSH_COMMAND="ssh -i $ssh_path" git clone $repo_ssh_address $repo_name
    cd $repo_name
    gus $ssh_name
end

function ghcl -a ssh_name repo_shorthand repo_name
    gcl $ssh_name git@github.com:$repo_shorthand.git $repo_name
end

## Caches & untracked files

alias grm   'git rm -r --cached .'
alias gcln  'git clean -fd'

## Status

alias gs    'git status'

function gsw
    while true
        set git_tmp_diff (git --no-optional-locks status)
        if test "$git_diff" != "$git_tmp_diff"
            set git_diff $git_tmp_diff
            clear && printf '\e[3J'
            git --no-optional-locks status
        end
        sleep 1.5
    end
end

alias gl    'git log'

function glw
    while true
        set git_tmp_diff (git --no-optional-locks --no-pager log --abbrev-commit --pretty=oneline -10)
        if test "$git_diff" != "$git_tmp_diff"
            set git_diff $git_tmp_diff
            clear && printf '\e[3J'
            git --no-optional-locks --no-pager log --abbrev-commit --pretty=oneline -10
        end
        sleep 3
    end
end

## Branching

alias gb       'git branch'
alias gba      'gb -a'
alias gbm      'git branch -m'

function gbcln
    git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
end

function gco -a branch_search_term
    set local_branch (branch_containing $branch_search_term)

    if not test -d $local_branch
        git checkout $local_branch
    else
        set remote_branch (remote_branch_containing $branch_search_term)
        gcor $remote_branch
    end
end

function gcop
    gco $argv
    gp
end

alias mtr       'git checkout master'
alias mtrp      'mtr && gp'
alias rel       'git checkout release'
alias relp      'rel && gp'

function gcof -a files -w 'git checkout --'
    git checkout -- $files
end

alias gcoa      'git checkout -- .'

alias gbco      'git checkout -b'

function gcor -a branch_search_term
    gf
    git checkout -t (remote_branch_containing $branch_search_term)
    gbt
    gp
end

function gcora
    set all_remote_branches (git branch -r | cut -c 3-)
    gf
    for remote_branch in $all_remote_branches
        git checkout -t $remote_branch
        gbt
    end
end

function gbt
    set current_branch (current_branch)
    git branch -u origin/$current_branch $current_branch
end

function gbd -a branch_search_term
    set branch (branch_containing $branch_search_term)
    git branch -d $branch
end

function gbd! -a branch_search_term
    set branch (branch_containing $branch_search_term)
    git branch -D $branch
end

function gbdr -a branch_search_term
    set branch (branch_containing $branch_search_term)
    git push origin :$branch
end

## Resetting

alias grf    'git reset HEAD'
alias gra    'git reset .'

function gr
    git reset HEAD~$argv
end

function gr!
    git reset HEAD~$argv --hard
end

## Pulling

alias gf     'git fetch origin'
function gp
    gbt
    git pull origin --tags --rebase
    gbcln
end

## Diffing

alias gd     'git diff --color --indent-heuristic | diff-so-fancy'
alias gds    'git diff --staged --color --indent-heuristic | diff-so-fancy'
alias gda    'git diff --color --indent-heuristic HEAD | diff-so-fancy'

function gsh
    git show $argv | diff-so-fancy
end

function gdaw
    set git_diff /dev/null

    while true
        set git_tmp_diff (git --no-optional-locks --no-pager diff HEAD)
        if test "$git_diff" != "$git_tmp_diff"
            set git_diff $git_tmp_diff
            clear && printf '\e[3J'
            if test -n "$git_diff"
                git diff --color --indent-heuristic HEAD | diff-so-fancy # ':(exclude)*.pbxproj'
            else
                cat (random choice $FISH_CONFIG_PATH/resources/ascii/*)
            end
        end
        sleep 1.5
    end
end

## Staging

function ga -a files -w 'git add'
    switch (count $files)
    case 0
        git cola
    case '*'
        git add $files
    end
end

alias gaa    'git add .'

## Stashing

alias gstl   'git stash list'

alias gst    'git stash --include-untracked --quiet'
alias gstf   'git stash push --include-untracked --quiet'

function gsts -a index
    git stash show -p stash@\{$index\}
end

function gsta
    if test -d $argv
        git stash apply --index --quiet
    else
        git stash apply stash@\{$argv\} --index --quiet
    end
end

function gstd
    git stash drop stash@\{$argv\}
end

alias gstcln 'git stash clear .'

## Commiting

alias gc     'git commit'
alias gcm    'git commit -m'
alias gca    'git commit --amend'
alias gce    'git commit --allow-empty'

alias gcp    'git cherry-pick'

## Tagging

alias gt     'git tag'

function gtd
    git tag -d $argv
end

function gtd!
    git tag -D $argv
end

function gtdr
    git push origin :refs/tags/$argv
end

## Merging

function gm -a branch_search_term
    set current_branch (current_branch)
    set branch_to_merge (branch_containing $branch_search_term)
    gcop $branch_to_merge
    git checkout $current_branch
    git merge $branch_to_merge
end

alias gmmtr  'gm master'
alias gmrel  'gm release'

## Pushing

alias gps    'git push -u origin HEAD'
alias gps!   'gps --force'
