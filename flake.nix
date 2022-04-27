{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { home-manager, darwin, nixpkgs, nixpkgs-unstable, ... }:
    let
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          system = prev.system;
          config = { allowUnfree = true; };
        };
      };
      packages = system:
        import nixpkgs {
          inherit system;
          overlays = [ overlay-unstable ];
        };
      stateVersion = "21.11";
    in {
      homeConfigurations = {
        mila = home-manager.lib.homeManagerConfiguration rec {
          inherit stateVersion;
          system = "aarch64-darwin";
          pkgs = packages system;
          username = "aige";
          homeDirectory = "/Users/${username}";

          # Specify the path to your home configuration here
          configuration = import ./home.nix {
            imports = [
              ./modules/development.nix
              ./modules/finance.nix
              ./modules/terminal.nix
              ./modules/programs/emacs.nix
              ./modules/programs/fish.nix
              ./modules/programs/neovim.nix
            ];
            inherit pkgs system username;
          };
        };
      };

      darwinConfigurations = {
        Jill = darwin.lib.darwinSystem rec {
          system = "x86_64-darwin";
          pkgs = packages system;
          modules = [
            home-manager.darwinModules.home-manager
            ./computers/Jill.nix
            ./modules/darwin/system.nix
            ./modules/darwin/brew.nix
            ./modules/darwin/brew/browsers.nix
            ./modules/darwin/brew/development.nix
            ./modules/darwin/brew/note-taking/personal.nix
            ./modules/darwin/brew/photography.nix
            ./modules/darwin/brew/productivity.nix
            ./modules/darwin/brew/social.nix
            ./modules/darwin/brew/terminal.nix
            ./modules/darwin/brew/utils.nix
          ];
          # These are passed down to all nix-darwin modules
          specialArgs = { inherit stateVersion; };
        };
      };
    };
}
