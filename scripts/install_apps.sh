#!/usr/bin/env bash

export HOMEBREW_NO_AUTO_UPDATE=1

ask_install() {
    echo -n "$1 (y/n)? " >&2
    read should_install
    echo $should_install
}

brew_install_if_true() {
    should_install=$2
    if [ "$should_install" != "${should_install#[Yy]}" ]; then
        brew cask install $1
    else
        return 1
    fi
}

brew_install_if_false() {
    should_install=$2
    if [ "$should_install" != "${should_install#[Nn]}" ]; then
        brew cask install $1
    else
        return 1
    fi
}

should_install_plex_ms=`ask_install "Is this machine a Plex server?"`

mas install 1333542190                   # 1Password
brew cask install                          alfred
brew cask install                          archiver
brew cask install                          charles
mas install 411643860                    # DaisyDisk
brew cask install                          Deckset
mas install 1081413713                   # GIF Brewery 3
brew cask install                          google-chrome
brew cask install                          gpg-suite-no-mail
brew cask install                          iterm2
brew cask install                          keepingyouawake
mas install 409183694                    # Keynote
mas install 419330170                    # Moom
mas install 409203825                    # Numbers
brew cask install                          paw
brew cask install lukakerr/things/pine   # Pine
brew_install_if_true                       plex-media-server $should_install_plex_ms
brew_install_if_false                      plex $should_install_plex_ms
brew cask install                          protonmail-bridge
brew_install_if_true                       radarr $should_install_plex_ms
brew cask install                          sketch
mas install 803453959                    # Slack
brew_install_if_true                       sonarr $should_install_plex_ms
chmod +x /Applications/Sonarr.app/Contents/MacOS/Sonarr
brew cask install                          spotify
brew cask install                          sublime-text
mas install 747648890                    # Telegram
mas install 904280696                    # Things 3
brew cask install                          tor-browser
brew_install_if_true                       torguard $should_install_plex_ms
brew_install_if_true                       transmission $should_install_plex_ms
brew cask install                          vlc

curl -s https://raw.githubusercontent.com/vineetchoudhary/Downloader-for-Apple-Developers/master/install.sh | bash # Xcode Downloader
rm -rf Downloader.tar.gz
