#!/bin/bash

echo "Setting macOS defaults..."

# Set dock to bottom of screen
defaults write com.apple.dock "orientation" -string "bottom"

# Set dock tile size
defaults write com.apple.dock "tilesize" -int "48"

# Set dock autohide
defaults write com.apple.dock "autohide" -bool "true"

# Set dock genie effect
defaults write com.apple.dock "mineffect" -string "genie"

# Show all file extensions in the Finder
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# Show hidden files in the Finder
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"

# Set the default view style for folders without custom setting (Nlsv = List View)
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

# Choose whether the default file save location is on disk or iCloud (false = disk)
defaults write NSGlobalDomain "NSDocumentSaveNewDocumentsToCloud" -bool "false"

# Hide external disks on desktop
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool "false"

killall Dock
