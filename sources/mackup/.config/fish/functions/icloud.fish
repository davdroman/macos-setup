set ICLOUD_DRIVE_PATH $HOME/Library/Mobile\ Documents/com~apple~CloudDocs

function cd_icloud
    cd $ICLOUD_DRIVE_PATH
end

function tf_icloud
    open -a Finder $ICLOUD_DRIVE_PATH
end

function ed_icloud
    code $ICLOUD_DRIVE_PATH
end
