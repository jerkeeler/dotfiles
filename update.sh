#!/usr/bin/env bash

# Pull the latest code from the origin
git pull

# Run stow to link any new configs
stow configs/

# Update any brew files with bundle install
brew bundle install
