set MACOS_SETUP_PATH ~/Library/Mobile\ Documents/com~apple~CloudDocs/macOS

function cd_macos
    cd $MACOS_SETUP_PATH
end

function tf_macos
    open -a Finder $MACOS_SETUP_PATH
end

function ed_macos
    code $MACOS_SETUP_PATH
end

function reset_launchpad
    defaults write com.apple.dock ResetLaunchPad -bool true
    killall Dock
end
