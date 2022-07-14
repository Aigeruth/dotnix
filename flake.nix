{
  description = "Home Manager configuration";

  inputs = {
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ledger-flake = {
      url = "github:ledger/ledger";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { home-manager, darwin, emacs, flake-utils, ledger-flake, nixpkgs
    , nixpkgs-unstable, ... }:
    let
      inherit (flake-utils.lib) eachDefaultSystem eachDefaultSystemMap;
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit (prev) system;
          config = { allowUnfree = true; };
        };
      };
      overlay-ledger = final: prev: {
        inherit (ledger-flake.packages.${prev.system}) ledger;
      };
      packages = system:
        import nixpkgs {
          inherit system;
          overlays = [ overlay-unstable emacs.overlay overlay-ledger ];
          config = {
            allowUnfreePredicate = pkg:
              builtins.elem (nixpkgs.lib.getName pkg) [ "1password-cli" ];
          };
        };
      stateVersion = "22.05";

      mkDarwin = { system, modules, username }:
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            home-manager.darwinModules.home-manager
            ./modules/darwin/system.nix
            ./modules/darwin/brew.nix
            ./modules/darwin/shells.nix
          ] ++ modules;
          pkgs = packages system;
          # These are passed down to all nix-darwin modules
          specialArgs = { inherit stateVersion username; };
        };
    in {
      darwinConfigurations = {
        Jill = mkDarwin {
          system = "x86_64-darwin";
          username = "nagyg";
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
          username = "aige";
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
        work = mkDarwin {
          system = "x86_64-darwin";
          username = "gabornagy";
          modules = [
            ./computers/work.nix
            ./modules/darwin/brew/browsers.nix
            ./modules/darwin/brew/development.nix
            ./modules/darwin/brew/note-taking/work.nix
            ./modules/darwin/brew/terminal.nix
            ./modules/darwin/brew/work.nix
          ];
        };
      };
      devShells = eachDefaultSystemMap (system:
        let pkgs = packages system;
        in {
          default = pkgs.mkShell {
            nativeBuildInputs = [ pkgs.unstable.nixfmt pkgs.unstable.statix ];
          };
        });

      checks = eachDefaultSystemMap (system:
        let pkgs = packages system;
        in {
          nixfmt = pkgs.runCommand "check-with-nixfmt" {
            nativeBuildInputs = [ pkgs.findutils pkgs.unstable.nixfmt ];
          } ''
            touch $out
            ${pkgs.findutils}/bin/find ${
              ./.
            } -name '*.nix' -type f -print0 | xargs -0 ${pkgs.unstable.nixfmt}/bin/nixfmt --check
          '';

          statix = pkgs.runCommand "check-with-statix" {
            nativeBuildInputs = [ pkgs.unstable.statix ];
          } ''
            touch $out
            ${pkgs.unstable.statix}/bin/statix check ${./.}
          '';
        });

      formatter = eachDefaultSystemMap
        (system: let pkgs = packages system; in pkgs.unstable.nixfmt);
    };
}
