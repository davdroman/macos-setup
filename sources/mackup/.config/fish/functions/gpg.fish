function gpgd
    pbpaste | gpg -d > /tmp/gpgdpb
    echo
    cat /tmp/gpgdpb
    rm /tmp/gpgdpb
end
