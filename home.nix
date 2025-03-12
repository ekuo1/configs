{ config, pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  # List of packages to install for this user
  home.packages = with pkgs; [
    zsh
    tmux
    vim
  ];

  # Enable Zsh
  programs.zsh.enable = true;

  programs.vim = {
    enable = true;
  };

  # Set the Home Manager state version
  home.stateVersion = "24.11";  # Adjust to your NixOS version
}
