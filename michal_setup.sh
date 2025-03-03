#!/bin/bash
set -e

# install brew on linux
if ! command -v brew >/dev/null 2>&1; then
 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update package list and upgrade installed packages
sudo apt update && sudo apt upgrade -y

# Install standard utilities and dependencies for building Python and Neovim
sudo apt install -y \
  git tmux zsh curl build-essential wget software-properties-common gcc trash-cli screen


# Install Neovim (latest stable via Neovim Team PPA)
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y neovim

# Set zsh as the default shell for the current user
chsh -s "$(which zsh)"

# Clone dotfiles repository if not already cloned
DOTFILES_DIR="$HOME/dot-files"
if [ ! -d "$DOTFILES_DIR" ]; then
  git clone https://github.com/mikh3x4/dot-files.git "$DOTFILES_DIR"
  # If an install script exists, run it
  if [ -f "$DOTFILES_DIR/install.sh" ]; then
    bash "$DOTFILES_DIR/install.sh"
  fi
fi

# Install pyenv (along with pyenv-virtualenv) if not already installed
if [ ! -d "$HOME/.pyenv" ]; then
  curl https://pyenv.run | bash
fi

# Add pyenv configuration to .zshrc if not already present
SHELL_RC="$HOME/.zshrc"
if ! grep -q 'pyenv init' "$SHELL_RC"; then
  {
    echo ""
    echo "# Pyenv configuration"
    echo 'export PYENV_ROOT="$HOME/.pyenv"'
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"'
    echo 'eval "$(pyenv init --path)"'
    echo 'eval "$(pyenv init -)"'
    echo 'eval "$(pyenv virtualenv-init -)"'
  } >> "$SHELL_RC"
fi

# Source the updated shell configuration
# shellcheck source=/dev/null
source "$SHELL_RC"

# Install Python 3.10 (skip if already installed)
pyenv install -s 3.10.10
pyenv global 3.10.10

#install aichat
brew install aichat

echo "Setup complete. Please restart your shell for all changes to take effect."


