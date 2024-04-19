# @source: https://github.com/thoughtbot/laptop/blob/main/mac

# Determine Homebrew prefix
arch="$(uname -m)"
if [ "$arch" = "arm64" ]; then
  HOMEBREW_PREFIX="/opt/homebrew"
else
  HOMEBREW_PREFIX="/usr/local"
fi

# Install guide : https://docs.brew.sh/Installation
if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    append_to_zshrc "eval \"\$($HOMEBREW_PREFIX/bin/brew shellenv)\""

    export PATH="$HOMEBREW_PREFIX/bin:$PATH"
fi

brew bundle --file=- <<EOF
# Unix tools
brew "git"     # Install git
brew "tig"     # Install tig
brew "gnupg"   # GnuPG for signed commit
brew "vim"     # Install vim

# Helpers
brew "git-delta"   # Install delta: Delta a better diff tool
brew "httpie"      # Install httpie: Modern, user-friendly command-line HTTP client for the API era.
brew "gh"          # Install gh: GitHub command-line interface
brew "jq"          # Install jq: Command-line JSON processor
brew "gh"          # Intall gh: Github CLI

# Ruby
brew "rbenv"
brew "ruby-build"

# Node
# Install nvm instead of node

# Database
brew "postgresql@16", restart_service: :changed
brew "mysql"

# Applications
cask "rectangle"            # https://rectangleapp.com/
cask "raycast"              # https://www.raycast.com/
cask "visual-studio-code"   # https://code.visualstudio.com/
cask "beekeeper-studio"     # https://www.beekeeperstudio.io/
cask "bitwarden"            # https://bitwarden.com/
cask "docker"               # https://www.docker.com/products/docker-desktop
cask "firefox"              # https://www.mozilla.org/firefox/
cask "iterm2"               # https://iterm2.com/
cask "itsycal"              # https://www.mowglii.com/itsycal/
cask "spotify"              # https://www.spotify.com/
cask "imageoptim"           # https://imageoptim.com/mac
EOF

echo "Homebrew: Configuration is done"
