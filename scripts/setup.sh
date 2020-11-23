#!/usr/bin/env bash

# Prompts

ask() {
    echo -n "$1 " >&2
    read -e should_install
    echo $should_install
}

should_install_plex_ms=`ask "Is this machine a Plex server? (y/n)"`

# Xcode

sudo gem install xcode-install
xcversion update
xcversion list
xcode_version=`ask "Which Xcode version to install?"`
xcversion install "$xcode_version"

# Homebrew

if ! which brew >/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
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

# Ruby

rbenv install --list
ruby_version=`ask "Which Ruby version to install?"`
RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl)" rbenv install "$ruby_version"
rbenv global "$ruby_version"

# Install fonts in resources folder

cp -f $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/macOS/resources/fonts/* $HOME/Library/Fonts

# Allow QuickLook plugins

xattr -d -r com.apple.quarantine ~/Library/QuickLook

# Set defaults

mkdir -p "$HOME/Development"

ln -sf "$HOME/Library/Mobile Documents/com~apple~CloudDocs/macOS/sources/mackup/.mackup.cfg" "$HOME"
mackup restore -f

defaults write com.apple.iphonesimulator AllowFullscreenMode -bool YES

git config --global remote.origin.prune true
