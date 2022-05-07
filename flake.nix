{
  description = "Home Manager configuration";

  inputs = {
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { home-manager, darwin, flake-utils, nixpkgs, nixpkgs-unstable, ... }:
    let
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit (prev) system;
          config = { allowUnfree = true; };
        };
      };
      packages = system:
        import nixpkgs {
          inherit system;
          overlays = [ overlay-unstable ];
        };
      stateVersion = "21.11";

      mkDarwin = { system, modules }:
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            home-manager.darwinModules.home-manager
            ./modules/darwin/system.nix
            ./modules/darwin/brew.nix
          ] ++ modules;
          pkgs = packages system;
          # These are passed down to all nix-darwin modules
          specialArgs = { inherit stateVersion; };
        };
    in {
      darwinConfigurations = {
        Jill = mkDarwin {
          system = "x86_64-darwin";
          modules = [
            ./computers/Jill.nix
            ./modules/darwin/brew/browsers.nix
            ./modules/darwin/brew/development.nix
            ./modules/darwin/brew/note-taking/personal.nix
            ./modules/darwin/brew/photography.nix
            ./modules/darwin/brew/productivity.nix
            ./modules/darwin/brew/social.nix
            ./modules/darwin/brew/terminal.nix
            ./modules/darwin/brew/utils.nix
          ];
        };

        Mila = mkDarwin {
          system = "aarch64-darwin";
          modules = [
            ./computers/Mila.nix
            ./modules/darwin/brew/browsers.nix
            ./modules/darwin/brew/development.nix
            ./modules/darwin/brew/note-taking/personal.nix
            ./modules/darwin/brew/photography.nix
            ./modules/darwin/brew/productivity.nix
            ./modules/darwin/brew/social.nix
            ./modules/darwin/brew/terminal.nix
            ./modules/darwin/brew/utils.nix
            ./modules/darwin/brew/videography.nix
          ];
        };
      };
    } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = packages system;
      in {
        checks = {
          nixfmt = pkgs.runCommand "check-with-nixfmt" {
            buildinputs = [ pkgs.findutils pkgs.unstable.nixfmt ];
          } ''
            touch $out
            ${pkgs.findutils}/bin/find ${
              ./.
            } -name '*.nix' -type f -print0 | xargs -0 ${pkgs.unstable.nixfmt}/bin/nixfmt --check
          '';

          statix = pkgs.runCommand "check-with-statix" {
            buildinputs = [ pkgs.unstable.statix ];
          } ''
            touch $out
            ${pkgs.unstable.statix}/bin/statix check ${./.}
          '';
        };
      });
}
