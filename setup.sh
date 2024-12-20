#!/usr/bin/env bash

# Unattended installation of Command Line Tools
# Found on apple.stackexchange.com at https://apple.stackexchange.com/questions/107307/how-can-i-install-the-command-line-tools-completely-from-the-command-line/195963#195963
# Homebrew uses a similar technique https://github.com/Homebrew/install/blob/878b5a18b89ff73f2f221392ecaabd03c1e69c3f/install#L297
xcode-select -p >/dev/null || {
echo "Installing command line tools..."
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
CLT=$( softwareupdate -l |
  grep "\*.*Command Line Tools" |
  head -n 1 |
  awk -F ":" '{print $2}' |
  sed -e 's/^ *//' |
  tr -d '\n' )
softwareupdate -i "$CLT" --verbose
rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
}
echo "Command Line Tools are installed at $(xcode-select -p)"

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install everything in Brewfile
brew bundle install

# Install tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Setup configs
stow configs/
