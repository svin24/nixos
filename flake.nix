{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # HP-x360
      nixosConfigurations = {
        nyx = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            ./hosts/nyx/configuration.nix
            inputs.home-manager.nixosModules.default
           ];
        };
      };

      # home manager
      #homeConfigurations = {
      #  john = home-manager.lib.homeManagerConfiguration{
      #    inherit pkgs;
      #    modules = [ ./john/home.nix ];
      #  };
      #};
      
      # add other devices here
    };
}
