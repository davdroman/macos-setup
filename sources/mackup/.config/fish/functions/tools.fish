function rot13
    echo $argv | tr 'A-Za-z' 'N-ZA-Mn-za-m'
end

function ytdl
    set url (pbpaste)
    youtube-dl -i -w -c "$url"
end
