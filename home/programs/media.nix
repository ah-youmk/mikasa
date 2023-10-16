{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    pipewire
    wireplumber
    mpc-cli
    playerctl
    ncmpcpp
    mpv
  ];
}
