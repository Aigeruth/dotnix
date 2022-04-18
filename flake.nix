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
      packages = system:
        import nixpkgs {
          inherit system;
          overlays = [
            overlay-unstable
          ];
        };
    in {
      homeConfigurations = {
        mila = home-manager.lib.homeManagerConfiguration rec {
          stateVersion = "21.11";
          system = "aarch64-darwin";
          pkgs = packages system;
          username = "aige";
          homeDirectory = "/Users/${username}";

          # Specify the path to your home configuration here
          configuration = import ./home.nix {
	    imports = [
              ./modules/development.nix
              ./modules/terminal.nix
              ./modules/programs/fish.nix
            ];
            inherit pkgs system username;
          };
        };
      };
    };
}
