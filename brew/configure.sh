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
brew "vim"     # Install vim

# Helpers
brew "delta"   # Install delta: Delta a better diff tool
brew "httpie"  # Install httpie: Modern, user-friendly command-line HTTP client for the API era.
brew "gh"      # Install gh: GitHub command-line interface
brew "jq"      # Install jq: Command-line JSON processor

# Ruby
brew "rbenv"
brew "ruby-build"

# Node
# Install nvm instead of node

# Database
brew "postgres", restart_service: :changed
brew "mysql"
EOF

echo "Homebrew: Configuration is done"
