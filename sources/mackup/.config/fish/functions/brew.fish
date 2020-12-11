function brew_setup_clean
    if test -d $argv
        set BREWFILE_DEFAULT $MACOS_SETUP_PATH/scripts/Brewfile-Default
    else
        set BREWFILE_DEFAULT $MACOS_SETUP_PATH/scripts/Brewfile-PlexServer
    end

    cat $MACOS_SETUP_PATH/scripts/Brewfile-Core $BREWFILE_DEFAULT > /tmp/Brewfile
    brew bundle cleanup --file /tmp/Brewfile
end

function brew_setup_clean!
    if test -d $argv
        set BREWFILE_DEFAULT $MACOS_SETUP_PATH/scripts/Brewfile-Default
    else
        set BREWFILE_DEFAULT $MACOS_SETUP_PATH/scripts/Brewfile-PlexServer
    end

    cat $MACOS_SETUP_PATH/scripts/Brewfile-Core $BREWFILE_DEFAULT > /tmp/Brewfile
    brew bundle cleanup --file /tmp/Brewfile --force
end

function brew_upgrade_all
    CURL_SSL_BACKEND=secure-transport \
    brew upgrade --cask --greedy && \
    brew upgrade && \
    brew cleanup
end
