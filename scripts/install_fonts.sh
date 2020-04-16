#!/usr/bin/env bash

cp -f $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/macOS/resources/fonts/* $HOME/Library/Fonts

export HOMEBREW_NO_AUTO_UPDATE=1

brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
brew cask install font-jetbrainsmono-nerd-font
