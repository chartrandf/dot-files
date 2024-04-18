# Repeat delay
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Faster key repeat
defaults write NSGlobalDomain KeyRepeat -int 2

# Disable press and hold funtions
defaults write -g ApplePressAndHoldEnabled -bool false

# Use current directory as default search scope in Finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Show hidden files and folders on Finder
defaults write com.apple.finder AppleShowAllFiles -boolean true
killall Finder

# Change screenshot file from PNG to JPG (smaller filesize)
defaults write com.apple.screencapture type jpg
killall SystemUIServer

# Hot Corners → Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock orientation right
defaults write com.apple.dock autohide -int 1
killall Dock

# Global scripts folder
mkdir ~/scripts

echo "OSX: Global configuration is done"
