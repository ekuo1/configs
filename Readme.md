## Setup NixOS on WSL2

1. Install it with these steps: https://github.com/nix-community/NixOS-WSL
1. Connect to it with `wsl -d NixOS`
1. Follow the prompts to update the version
1. Create a script with `nano init.sh`
1. Copy the contents of the `init.sh` script into the script
1. `chmod +x init.sh`
1. `sudo bash init.sh`
1. Rebuild the OS with `sudo nixos-rebuild switch`
1. Run `git init` in  