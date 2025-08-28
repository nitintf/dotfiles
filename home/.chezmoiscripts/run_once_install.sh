#!/bin/bash

# This script runs once when chezmoi init is executed
# It installs Homebrew dependencies and sets up the system

set -e

echo "🚀 Setting up your system with chezmoi..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew is already installed"
fi

# Update Homebrew
echo "🔄 Updating Homebrew..."
brew update

# Install essential packages
echo "📦 Installing essential packages..."
brew install \
    fish \
    git \
    lazygit \
    gh \
    fzf \
    starship \
    tmux \
    neovim \
    bat \
    exa \
    fd \
    ripgrep \
    jq \
    yq \
    htop \
    wget \
    curl \
    unzip \
    zoxide \
    tldr \
    neofetch

# Install development tools
echo "🛠️ Installing development tools..."
brew install \
    node \
    python \
    go

# Install Cask applications
echo "💻 Installing GUI applications..."
brew install --cask \
    zen \
    cursor \
    iterm2 \
    rectangle \
    raycast \
    appcleaner \
    dbeaver-community \
    slack \
    obsidian
    # the-unarchiver \
    # firefox \
    # google-chrome \
    # spotify \
    # discord \
    # zoom \
    # notion \

# Install fonts
echo "🔤 Installing fonts..."
brew tap homebrew/cask-fonts
brew install --cask \
    font-fira-code \
    font-fira-code-nerd-font \
    font-jetbrains-mono \
    font-jetbrains-mono-nerd-font \
    font-hack-nerd-font \
    font-meslo-lg-nerd-font \
    font-sf-mono-nerd-font

# Clean up
echo "🧹 Cleaning up..."
brew cleanup

echo "✅ Installation complete! Your system is now set up with all the essential tools."