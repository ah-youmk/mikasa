{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common.nix
    ./git.nix
    ./media.nix
    ./rofi
    ./anyrun.nix
  ];
}
