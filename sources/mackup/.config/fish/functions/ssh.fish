eval (ssh-agent -c > /dev/null) && ssh-add

function gug -d 'Git User Generate: generates new ssh key' -a username email
    set ssh_path (ssh-path $username)
    ssh-keygen -t rsa -b 4096 -f $ssh_path -C "$email"
    pbcopy < $ssh_path.pub
end

function gua -d 'Git User Add: adds user key to ssh keychain' -a username
    set ssh_path (ssh-path $username)
    ssh-add -K $ssh_path
end

function ghut -d 'GitHub User Test: attempts GitHub auth with specified user' -a username
    set ssh_path (ssh-path $username)
    ssh -i $ssh_path -T git@github.com
end

function gus -d 'Git User Set: sets user key and details to be used in a specific repo' -a username
    set ssh_path $HOME/.ssh/id_rsa_$username
    git config core.sshCommand "ssh -i $ssh_path"
    set email (cat $ssh_path.pub | cut -d ' ' -f3)
    git config user.name $username
    git config user.email $email
end
