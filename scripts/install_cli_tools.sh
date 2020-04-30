#!/usr/bin/env bash

# Xcode CLI Tools

if ! which xcodebuild >/dev/null; then
    xcode-select --install
fi

GEM_HOME=~/.gem gem install xcode-install

# Package Managers

if ! which brew >/dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

export HOMEBREW_NO_AUTO_UPDATE=1

# CLIs

brew install carthage
brew install coreutils
brew install diff-so-fancy
brew install firebase-cli
brew install fish
brew install git
brew install git-cola
brew install git-crypt
brew install imagemagick
brew install eddieantonio/eddieantonio/imgcat
brew install mackup
brew install mas
brew install micro
brew install node
brew install now-cli
brew install qrencode
brew install sourcery
brew install speedtest-cli
brew install swiftlint
brew install youtube-dl
brew install keith/formulae/zap
