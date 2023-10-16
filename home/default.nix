{ config, pkgs, inputs, ... }:

{
#  wayland.windowManager.hyprland.extraConfig = ''
#    $mod = SUPER
#
#    bind = $mod, F, exec, firefox
#    bind = , Print, exec, grimblast copy area
#
#    ${builtins.concatStringsSep "\n" (builtins.genList (
#        x: let
#	  ws = let
#	    c = (x + 1) / 10;
#	  in
#	    builtins.toString (x + 1 - (c * 10));
#	  in '' 
#             bind = $mod, ${ws}, workspace, ${toString (x + 1)}
#	     bind $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
#	  ''
#    )
#    10)}
#  '';

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome.gnome-themes-extra;
      name = "Adwaita-dark";
    };
  };

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
