{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:#@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      #x360
      nixosConfigurations = {
        x360 = nixpkgs.lib.nixosSystem {
          #specialArgs = {inherit inputs;};
          inherit system;
          modules = [ ./hosts/x360/configuration.nix ];
        };
      };

      # home manager
      homeConfurations = {
        john = home-manager.lib.homeManagerConfiguration{
          inherit pkgs;
          moodules = [ ./john/home.nix ];
        };
      };
      
      # add other devices here
    };
}
