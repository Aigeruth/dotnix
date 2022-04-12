{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { home-manager, nixpkgs, nixpkgs-unstable, ... }:
    let
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
	  system = prev.system;
          config = {
            allowUnfree = true;
          };
        };
      };
      pkgs-aarch64-darwin = import nixpkgs {
        system = "aarch64-darwin";
	overlays = [
          overlay-unstable
        ];
      };
      pkgs-x86_64-darwin = import nixpkgs {
        system = "x86_64-darwin";
	overlays = [
          overlay-unstable
        ];
      };
    in {
      homeConfigurations = {
        mila = home-manager.lib.homeManagerConfiguration rec {
          stateVersion = "21.11";
          system = "aarch64-darwin";
          pkgs = pkgs-aarch64-darwin;
          username = "aige";
          homeDirectory = "/Users/${username}";

          # Specify the path to your home configuration here
          configuration = import ./home.nix {
	    imports = [
              ./modules/development.nix
              ./modules/terminal.nix
            ];
            inherit pkgs system username;
          };
        };
      };
    };
}
