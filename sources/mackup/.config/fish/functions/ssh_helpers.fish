function ssh-path -d 'Gets SSH path for specified username' -a username
    echo $HOME/.ssh/id_rsa_$username
end
