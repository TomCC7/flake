{
  description = "CC's system flake config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, nur }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        inspiron = lib.nixosSystem {
          inherit system;
          modules = [
            ./system/configuration.nix
            ./hardwares/inspiron.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.cc = {
                imports = [ ./home/home.nix ];
              };
            }
            # add nur into pkgs
            {nixpkgs.overlays = [ nur.overlay ];}
          ];
        };
      };
    };
}
