{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nvf, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.system.default = 
      (nvf.lib.neovimConfiguration{
	pkgs = pkgs;
	modules = [ ./nvf.nix ];
      }).neovim;
      # HP-x360
      nixosConfigurations = {
        hpx360 = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            ./hosts/hpx360/configuration.nix
            nvf.nixosModules.default
            inputs.home-manager.nixosModules.default
           ];
        };
      };

      # add other devices here
    };
}
