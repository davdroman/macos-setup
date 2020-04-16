function branch_containing -a search_term
    set all_branches (git for-each-ref refs/heads | cut -d/ -f3-)

    for i in $all_branches
        switch $i
        case '*'$search_term'*'
            echo $i
            break
        end
    end
end

function remote_branch_containing
    set branch_matches (git branch -r | cut -c 3- | cut -d ' ' -f1 | grep $argv)
    echo $branch_matches[1]
end

function branches_containing
    set all_branches (git for-each-ref refs/heads | cut -d/ -f3-)
    set branches

    for i in $all_branches
        switch $i
        case '*'$argv'*'
            set branches $branches $i
        end
    end

    echo $branches | tr ' ' \n
end

function remote_containing
    set all_remotes (git remote | grep $argv[1])

    switch (count $all_remotes)
    case 0
        echo
    case '*'
        echo $all_remotes[1]
    end
end

function current_branch
    echo (git rev-parse --abbrev-ref HEAD)
end
