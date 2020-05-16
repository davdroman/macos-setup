set ICLOUD_DRIVE_PATH $HOME/Library/Mobile\ Documents/com~apple~CloudDocs

function cd_icloud
    cd $ICLOUD_DRIVE_PATH
end

function tf_icloud
    open -a Finder $ICLOUD_DRIVE_PATH
end

function subl_icloud
    subl $ICLOUD_DRIVE_PATH
end
