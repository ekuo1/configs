#!/bin/bash

set -e  # Exit immediately if a command fails

# Run all git commands inside a nix-shell
nix-shell -p git --run "
    # Navigate to /etc/nixos
    cd /etc/nixos || { echo 'Failed to cd into /etc/nixos'; exit 1; }

    # Initialize git repository if not already initialized
    if [ ! -d .git ]; then
        echo 'Initializing git repository...'
        sudo git init --initial-branch=main
    fi

    # Add remote and fetch the latest changes
    sudo git remote add origin https://github.com/ekuo1/configs.git || true  # Ignore error if remote already exists
    sudo git fetch origin main

    echo 'Resetting local files to match remote...'
    sudo git reset --hard origin/main  # WARNING: This overwrites local changes!
"
mkdir -p ~/.vim/colors
curl -o ~/.vim/colors/gruvbox.vim https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim

# Add and update the Home Manager channel. Version should match nixos version.
echo "Adding Home Manager channel..."
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
sudo nix-channel --update

# Rebuild NixOS
echo "Rebuilding NixOS..."
sudo nixos-rebuild switch

home-manager switch

echo "Setup complete!"
