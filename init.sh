#!/bin/bash

set -e  # Exit immediately if a command fails

# Update NixOS
sudo nix-channel --update
sudo nixos-rebuild switch

# Run all git commands inside a nix-shell
nix-shell -p git --run "
    # Navigate to /etc/nixos
    cd /etc/nixos || { echo 'Failed to cd into /etc/nixos'; exit 1; }

    # Initialize git repository if not already initialized
    if [ ! -d .git ]; then
        echo 'Initializing git repository...'
        git init --initial-branch=main
    fi

    # Add remote and fetch the latest changes
    git remote add origin https://github.com/ekuo1/configs.git || true  # Ignore error if remote already exists
    git fetch origin main

    echo 'Resetting local files to match remote...'
    git reset --hard origin/main  # WARNING: This overwrites local changes!
"

# Add and update the Home Manager channel
echo "Adding Home Manager channel..."
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

# Rebuild NixOS
echo "Rebuilding NixOS..."
sudo nixos-rebuild switch

echo "Setup complete!"
