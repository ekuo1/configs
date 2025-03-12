{ config, pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  # List of packages to install for this user
  home.packages = with pkgs; [
    tmux
  ];

  # Enable Zsh
  programs.zsh.enable = true;

  programs.vim = {
    enable = true;

    # Add your custom vim settings here
    extraConfig = ''
      set smartindent
      set tabstop=2
      set expandtab
      set shiftwidth=2
      color koehler
      set visualbell
      set t_vb=
      set vb t_vb=
      set noerrorbells
      set belloff=all
      set pastetoggle=<F3>
    '';
  };

  # Set the Home Manager state version
  home.stateVersion = "24.11";  # Adjust to your NixOS version
}
