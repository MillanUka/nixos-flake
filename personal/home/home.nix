{ config, pkgs, ... }:

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
    cargo
    rustc
    go
    zellij
    calibre
    waybar
    nil
  ];

}

