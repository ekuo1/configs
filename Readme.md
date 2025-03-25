## Setup NixOS on WSL2

1. Install it with these steps: https://github.com/nix-community/NixOS-WSL
1. Connect to it with `wsl -d NixOS`
1. Create a script with `nano init.sh`
1. Copy the contents of the `init.sh` script into the script
1. `chmod +x init.sh`
1. `bash init.sh`. It should prompt you for a password.
2. sudo nixos-rebuild switch
3. currently need to run this twice
