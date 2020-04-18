#!/usr/bin/env bash

mkdir -p "$HOME/Development"
mkdir -p "$HOME/Downloads/Torrent/Complete"
mkdir -p "$HOME/Downloads/Torrent/Incomplete"

ln -sf "$HOME/Library/Mobile Documents/com~apple~CloudDocs/macOS/sources/mackup/.mackup.cfg" "$HOME/.mackup.cfg"
ln -sf "$HOME/Library/Mobile Documents/com~apple~CloudDocs/macOS/sources/.mackup" "$HOME/.mackup"
mackup restore -f

defaults write com.apple.iphonesimulator AllowFullscreenMode -bool YES
