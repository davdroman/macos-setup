#!/usr/bin/env bash

# Disable quarantine

sudo defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool NO
sudo defaults write com.apple.LaunchServices LSQuarantine -bool NO

# Prompts

ask() {
    echo -n "$1 " >&2
    read -e should_install
    echo $should_install
}

should_install_plex_ms=`ask "Is this machine a Plex server? (y/n)"`

# CLI Tools

CLI_TOOLS_DIR="/Library/Developer/CommandLineTools"

if [ ! -d $CLI_TOOLS_DIR ]; then
    xcode-select --install
fi

until [ -d $CLI_TOOLS_DIR ]; do
    sleep 3
done

sleep 10

# Homebrew

if ! which brew >/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ `uname -m` == 'arm64' ]]; then
    if ! which brew >/dev/null; then
        echo 'Adding /opt/homebrew/bin to $PATH'
        sudo echo -e "/opt/homebrew/bin\n$(cat /etc/paths)" > /etc/paths
    fi
fi

DIR=$(cd "$(dirname "$0")" && pwd)

brew bundle --file "$DIR/Brewfile-Core" --no-lock

if [ "$should_install_plex_ms" != "${should_install_plex_ms#[Yy]}" ]; then
    brew bundle --file "$DIR/Brewfile-PlexServer" --no-lock
    mkdir -p "$HOME/Downloads/Torrent/Complete"
    mkdir -p "$HOME/Downloads/Torrent/Incomplete"
else
    brew bundle --file "$DIR/Brewfile-Default" --no-lock
fi

if [[ `uname -m` == 'arm64' ]]; then
    if ! grep -q '/opt/homebrew/bin/fish' /etc/shells; then
        echo 'Adding /opt/homebrew/bin/fish to /etc/shells'
        sudo echo '/opt/homebrew/bin/fish' >> /etc/shells
    fi
    chsh -s /opt/homebrew/bin/fish
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

touch ~/.hushlogin # silence 'Last Login'

ln -sf "$HOME/Library/Mobile Documents/com~apple~CloudDocs/macOS/sources/mackup/.mackup.cfg" "$HOME"
mackup restore -f

defaults write com.apple.iphonesimulator AllowFullscreenMode -bool YES
