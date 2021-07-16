alias rf    'source ~/.config/fish/config.fish'

function _refresh --on-event fish_preexec
    if not test -n $argv[1]
        source ~/.config/fish/config.fish
    end
end

function fish_greeting

end

function cd_fish
    cd $FISH_CONFIG_PATH
end

function tf_fish
    open -a Finder $FISH_CONFIG_PATH
end

function ed_fish
    if test -d $argv
        code $FISH_CONFIG_PATH
    else
        code $FISH_CONFIG_PATH/functions/$argv.fish
    end
end
