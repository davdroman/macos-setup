alias ..         'cd ..'
abbr -a -- -     'cd -'
alias t          'tree'
alias lsa        'ls -a'
alias lsl        'ls -l'
alias lsla       'ls -la'
alias rmrf       'rm -rf'
alias unxip!     'xip -x'

function mkcd
    mkdir $argv
    cd $argv
end

function cdp
    cd ~/Development/"$argv"
end

function cdd
    cd ~/Downloads
end

function o
    set filename $argv[1]
    set lc_filename (echo $filename | tr '[:upper:]' '[:lower:]')

    switch $lc_filename
        case '*.png' '*.jpg' '*.gif' '*.svg'
            imgcat $filename
        case '*'
            open $filename
    end
end

function lookup
    find . -name "$argv"
end
