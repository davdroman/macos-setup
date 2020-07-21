#!/usr/bin/env bash

# Prompts

ask() {
    echo -n "$1 " >&2
    read -e should_install
    echo $should_install
}

should_install_plex_ms=`ask "Is this machine a Plex server? (y/n)"`

# Xcode + CLI Tools

if ! which xcversion >/dev/null; then
    GEM_HOME=~/.gem gem install xcode-install
fi

function xcversion () {
    GEM_HOME=~/.gem ~/.gem/bin/xcversion "$@"
}

xcversion update
xcversion list
xcode_version=`ask "Which Xcode version to install?"`
xcversion install "$xcode_version"

# Homebrew

if ! which brew >/dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

DIR=$(dirname "$(realpath -s "$0")")

brew bundle --file "$DIR/Brewfile-Core" --no-lock

if [ "$should_install_plex_ms" != "${should_install_plex_ms#[Yy]}" ]; then
    brew bundle --file "$DIR/Brewfile-PlexServer" --no-lock
    mkdir -p "$HOME/Downloads/Torrent/Complete"
    mkdir -p "$HOME/Downloads/Torrent/Incomplete"
else
    brew bundle --file "$DIR/Brewfile-Default" --no-lock
fi

# Install fonts in resources folder

cp -f $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/macOS/resources/fonts/* $HOME/Library/Fonts

# Allow QuickLook plugins

xattr -d -r com.apple.quarantine ~/Library/QuickLook

# Set defaults

mkdir -p "$HOME/Development"

ln -sf "$HOME/Library/Mobile Documents/com~apple~CloudDocs/macOS/sources/mackup/.mackup.cfg" "$HOME"
ln -sf "$HOME/Library/Mobile Documents/com~apple~CloudDocs/macOS/sources/.mackup" "$HOME"
mackup restore -f

defaults write com.apple.iphonesimulator AllowFullscreenMode -bool YES

git config --global remote.origin.prune true
