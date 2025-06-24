{ pkgs, ... }:

{

  imports = [
    ./config.nix
  ];

  home.username = "millanu";
  home.homeDirectory = "/home/millanu";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    alacritty
    wofi
    go
    gopls
    rustup
    zellij
    calibre
    waybar
    nil
    nodejs_24
    typescript
    typescript-language-server
    nodePackages.prettier
  ];

}

