{
  description = "Mi ... kasa?";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

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
	  }
	];
      };
    };

    homeConfigurations."ahmadreza@nixos" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    };
  };
}
