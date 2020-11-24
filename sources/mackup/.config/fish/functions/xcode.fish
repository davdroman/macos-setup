function xclist
    xcversion update
    xcversion list
end

function xcinstall
    xcversion update
    xcversion install $argv --force
end

function xcinstalled
    xcversion installed
end

function xcselect
    xcversion select $argv
end

function xcclean
    set folder_prefix $argv
    if not test -d $folder_prefix
        rm -rf ~/Library/Developer/Xcode/DerivedData/$argv* >/dev/null 2>/dev/null
    else
        rm -rf ~/Library/Developer/Xcode/DerivedData/* >/dev/null 2>/dev/null
    end
end

function xcwipe
    rm -rf ~/Library/Developer/Xcode/DerivedData
    rm -rf ~/Library/Caches/org.carthage.CarthageKit
    rm -rf ~/Library/Caches/carthage
    rm -rf ./Carthage
end

function xcsimrecord
    xcrun simctl io booted recordVideo ~/Downloads/sim_recording.mov -f
end

function xcsimopenurl
    xcrun simctl openurl booted $argv
end

function xcsimtidystatusbar -a device_name
    xcrun simctl status_bar "$device_name" override --time 9:41 --dataNetwork wifi --wifiMode active --wifiBars 3 --cellularMode active --cellularBars 4 --batteryState charged --batteryLevel 100
end
