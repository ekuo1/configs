{ config, pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  # List of packages to install for this user
  home.packages = with pkgs; [
    neofetch
    zsh
    tmux
  ];

  # Enable Zsh
  programs.zsh.enable = true;

  # Set the Home Manager state version
  home.stateVersion = "23.11";  # Adjust to your NixOS version
}
