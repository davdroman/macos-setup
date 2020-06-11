set MACOS_SETUP_PATH ~/Library/Mobile\ Documents/com~apple~CloudDocs/macOS

function cd_macos
    cd $MACOS_SETUP_PATH
end

function tf_macos
    open -a Finder $MACOS_SETUP_PATH
end

function subl_macos
    subl $MACOS_SETUP_PATH
end

function reset_launchpad
    defaults write com.apple.dock ResetLaunchPad -bool true
    killall Dock
end

function update_all_packages
    CURL_SSL_BACKEND=secure-transport \
    gem update (gem list | cut -d ' ' -f 1) && \
    gem cleanup && \
    brew cask upgrade && \
    brew upgrade && \
    brew cleanup
end
