function xcclean
    set folder_prefix $argv
    if not test -d $folder_prefix
        rm -rf ~/Library/Developer/Xcode/DerivedData/$argv* >/dev/null 2>/dev/null
    else
        rm -rf ~/Library/Developer/Xcode/DerivedData/* >/dev/null 2>/dev/null
    end
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
