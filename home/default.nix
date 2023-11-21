{ config, pkgs, inputs, ... }:

{
  imports = [
    ./programs
    ./shell
    ./system
  ];

  home.username = "ahmadreza";
  home.homeDirectory = "/home/ahmadreza";

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
