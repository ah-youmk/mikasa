{pkgs, ...}: {
  home.packages = with pkgs; [
    neofetch
    brightnessctl
    xdg-desktop-portal-hyprland
    swaybg
    inih
    pixman
    wob
    telegram-desktop
    libnotify
    waybar
    mako
    wlogout
    imv
    unzip
    blueman
    wl-clipboard
    clipman
    ripgrep
    fd
    acpi
  ];
}
