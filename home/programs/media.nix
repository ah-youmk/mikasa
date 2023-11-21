{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    pipewire
    wireplumber
  ];
}
