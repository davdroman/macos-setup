alias rf    'source ~/.config/fish/config.fish'

function _refresh --on-event fish_preexec
    if not test -n $argv[1]
        source ~/.config/fish/config.fish
    end
end

function fish_greeting

end

alias cd_fish   "cd '$FISH_CONFIG_PATH'"
alias tf_fish   "open -a Finder '$FISH_CONFIG_PATH'"

function subl_fish
    if test -d $argv
        subl $FISH_CONFIG_PATH
    else
        subl $FISH_CONFIG_PATH/functions/$argv.fish
    end
end
