# Repeat delay
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Faster key repeat
defaults write NSGlobalDomain KeyRepeat -int 1

# Disable press and hold funtions
defaults write -g ApplePressAndHoldEnabled -bool false

# Use current directory as default search scope in Finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Show hidden files and folders on Finder
defaults write com.apple.finder AppleShowAllFiles -boolean true
killall Finder

echo "OSX global vars configured"
