# Repeat delay
defaults write NSGlobalDomain InitialKeyRepeat -int 11

# Faster key repeat
defaults write NSGlobalDomain KeyRepeat -int 0

# Disable press and hold funtions
defaults write -g ApplePressAndHoldEnabled -bool false

echo "OSX global vars configured"
