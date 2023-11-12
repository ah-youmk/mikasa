{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;


  description = "Mi ... kasa?";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    anyrun ={
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, anyrun, ... }@inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
in {
    
    nixosConfigurations = {

      asus-fx506li = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

	specialArgs =  { inherit inputs; };
	modules = [
          ./hosts/asus-fx506li

	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.ahmadreza = import ./home;
	    home-manager.extraSpecialArgs = { inherit inputs; };	
	    home-manager.extraSpecialArgs = { inherit anyrun; };	
	  }
	];
      };
    };

    homeConfigurations."ahmadreza@nixos" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = {inherit inputs outputs;};
      modules = [
        hyprland.homeManagerModules.default
	{wayland.windowManager.hyprland.enable = true;}
      ];
    };
  };
}
