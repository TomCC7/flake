{
  description = "CC's system flake config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nix-matlab = {
      # Recommended if you also override the default nixpkgs flake, common among
      # nixos-unstable users:
      # inputs.nixpkgs.follows = "nixpkgs";
      url = "gitlab:doronbehar/nix-matlab";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, nix-matlab }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      flake-overlays = [
        nix-matlab.overlay
      ];
    in {
      nixosConfigurations = {
        inspiron = lib.nixosSystem {
          inherit system;
          modules = [
            ./system/laptop.nix
            ./system/i3.nix
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

        rog = lib.nixosSystem {
          inherit system;
          modules = [
            ./system/laptop.nix
            ./system/i3.nix
            ./system/configuration.nix
            ./hardwares/rog.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.cc = {
                imports = [ ./home/home.nix ];
              };
            }
            # add nur into pkgs
            {nixpkgs.overlays = [ nur.overlay ];}
            # matlab
            (import ./overlays/matlab.nix flake-overlays)
          ];
        };
      };
    };
}
