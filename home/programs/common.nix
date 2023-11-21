{pkgs, ...}: {
  home.packages = with pkgs; [
    neofetch
    pixman
    telegram-desktop
    unzip
    cloudflare-warp
  ];
}
