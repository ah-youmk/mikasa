{ config, pkgs, ... }: {
  
  home.packages = with pkgs; [
    nodejs
    go
    gcc
  ];
}
