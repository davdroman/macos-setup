function sshl -d 'Lists all SSH keys in the SSH Agent'
    ssh-add -l
end

function ssh-path -d 'Gets SSH key path for specified username' -a username
    echo $HOME/.ssh/id_rsa_$username
end
