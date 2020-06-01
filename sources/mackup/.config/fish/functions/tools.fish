function rot13
    echo $argv | tr 'A-Za-z' 'N-ZA-Mn-za-m'
end

function qr
    set text (pbpaste)
    qrencode -t ansiutf8 "$text"
end

function ytdl
    set url (pbpaste)
    youtube-dl "$url" --ignore-errors --continue --format mp4
end
