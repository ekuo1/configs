{ config, pkgs, ... }:

let
  custom_pkgs = import (builtins.fetchGit {
    name = "my-old-revision";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "9957cd48326fe8dbd52fdc50dd2502307f188b0d";
  }) {};
in {
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  # List of packages to install for this user
  home.packages = [
    pkgs.tmux
    (pkgs.python3.withPackages (ps: with ps; [
      pip
      virtualenv
      numpy
      requests
      pyyaml
    ]))
    pkgs.tenv
    pkgs.tflint
    pkgs.unzip
    pkgs.go
    custom_pkgs.check-jsonschema
    custom_pkgs.hugo
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
      set visualbell
      set t_vb=
      set vb t_vb=
      set noerrorbells
      set belloff=all
      set pastetoggle=<F3>
      colorscheme gruvbox
      set bg=dark
    '';
  };

  programs.bash= {
    enable = truel
    bashrcExtra = ''
      alias nixupdate='cd /etc/nixos && sudo git fetch origin main && sudo git reset origin/main --hard && nixos-rebuild switch'
      alias starthugo='cd ~'
    '';
  }

  # Set the Home Manager state version
  home.stateVersion = "24.11";  # Adjust to your NixOS version
  home.sessionVariables = {
    TFENV_TERRAFORM_VERSION = "1.10.5";
  };
}