## Setup NixOS on WSL2

1. Install it with these steps: https://github.com/nix-community/NixOS-WSL
1. Connect to it with `wsl -d NixOS`
1. Follow the prompts to update the version
1. Run `sudo nano /etc/nixos/configuration.nix` to edit file, and paste the config from this repo in there
1. Rebuild the OS with `sudo nixos-rebuild switch`
1. Run `git init` in  