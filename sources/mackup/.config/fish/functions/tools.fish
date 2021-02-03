function rot13
    echo $argv | tr 'A-Za-z' 'N-ZA-Mn-za-m'
end

function sha256f
    shasum -a 256 $argv | cut -d ' ' -f1
end

function qr
    set text (pbpaste)
    qrencode -t ansiutf8 "$text"
end

function dl
    curl -OL $argv
end

function ytdl
    set url (pbpaste)
    youtube-dl "$url" --ignore-errors --continue --no-overwrites --format mp4 --cookies "/Volumes/Media 2/YouTube/youtube.com_cookies.txt"
end

function video_compress
    set input_path $argv

    set dir (dirname $input_path)
    set file (basename $input_path)
    set file_name (echo "$file" | cut -d '.' -f1)

    set output_path $dir/$file_name"_compressed.mp4"

    ffmpeg -v quiet -stats -i "$input_path" -vcodec h264 -acodec aac "$output_path"
end

function video_compress_max
    set input_path $argv

    set dir (dirname $input_path)
    set file (basename $input_path)
    set file_name (echo "$file" | cut -d '.' -f1)

    set output_path $dir/$file_name"_compressed_max.mp4"

    ffmpeg -v quiet -stats -i "$input_path" -vcodec libx265 -crf 28 "$output_path"
end
