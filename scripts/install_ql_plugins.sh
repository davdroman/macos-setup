#!/usr/bin/env bash

export HOMEBREW_NO_AUTO_UPDATE=1

brew cask install qlcolorcode
brew cask install qlstephen
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install quicklookase
brew cask install qlvideo
brew cask install provisionql
brew cask install quicklookapk
brew cask install quicklook-pat
brew cask install webpquicklook
brew cask install google-hangouts

xattr -d -r com.apple.quarantine ~/Library/QuickLook
