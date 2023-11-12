# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
  ];
  
  nixpkgs.config.allowUnfree = true;
  nix.settings.substituters = [ "https://cache.nixos.org/" ];
  # nix.settings.substituters = [ "https://cache.nixos.org/" "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.kernelParams = [ "nvidia_drm.modeset=1" ];
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub.useOSProber = true;
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/mnt/ntfs1" = {
      device = "/dev/sda1";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" ];
  };

  programs.thunar.enable = true;

  programs.zsh.enable = true;

  users.users.ahmadreza.shell = pkgs.zsh;

  networking.hostName = "mikasa"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Tehran";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
#  console = {
#    font = "Lat2-Terminus16";
#    keyMap = "us";
#    useXkbConfig = true; # use xkbOptions in tty.
#  };

  # Enable the X11 windowing system.
#  services.xserver.enable = true;

  programs.regreet.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

#  services.wayland.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
     modesetting.enable = true;
     open = false;
     package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  # Configure keymap in X11
#  services.xserver.layout = "us";
#  services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ahmadreza = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      google-chrome
      tree
      python3
    ];
  };

  fonts = {
  enableDefaultPackages = true;
  packages = with pkgs; [ 
    vazir-fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  fontconfig = {
    defaultFonts = {
      serif = [ "Vazirmatn" "JetBrainsMono" ];
      sansSerif = [ "Vazirmatn" "JetBrainsMono" ];
    };
  };
};

security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  wireplumber.enable = true;
  pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;
};
  
  services.mpd = {
  enable = true;
  musicDirectory = "/home/ahmadreza/music";
  extraConfig = ''
    audio_output {
      type "pipewire"
      name "My PipeWire Output"
    }
    '';
  # Optional:
  network.listenAddress = "any"; # if you want to allow non-localhost connections
};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    openconnect
    git
    fuse
    qt5ct
    libva
    jq
    meson
    ninja
    pavucontrol
    rustup
    gtk4
    polkit-kde-agent
    #inputs.fufexan.packages."x86_64-linux".eww
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
