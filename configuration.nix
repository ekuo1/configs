# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  environment.systemPackages = with pkgs; [
    wget
    git
    vim
  ];

  system.activationScripts.gitRepoSetup = ''
    if [ ! -d /etc/nixos/.git ]; then
      cd /etc/nixos
      ${pkgs.git}/bin/git init
      ${pkgs.git}/bin/git remote add origin https://github.com/ekuo1/configs.git
      ${pkgs.git}/bin/git fetch origin main
      ${pkgs.git}/bin/git reset --hard origin/main  # Overwrites all local changes
    else
      cd /etc/nixos
      ${pkgs.git}/bin/git pull origin main
    fi
  '';

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs; # only for NixOS 24.05
  };

}