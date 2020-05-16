set FISH_CONFIG_PATH (dirname (realpath (status --current-filename)))

for FILE in $FISH_CONFIG_PATH/functions/*
    source $FILE
end
