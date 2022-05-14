{ pkgs, system, stateVersion, ... }:

{
  users.users.gabornagy = {
    name = "gabornagy";
    home = "/Users/gabornagy";
  };
  home-manager = {
    users.gabornagy = {
      imports = [
        ../modules/home-manager/development.nix
        ../modules/home-manager/terminal.nix
        ../modules/home-manager/programs/direnv.nix
        ../modules/home-manager/programs/fish.nix
        ../modules/home-manager/programs/home-manager.nix
        ../modules/home-manager/programs/neovim.nix
        ../modules/home-manager/programs/starship.nix
      ];

      home.stateVersion = stateVersion;
    };
    # These are passed down to all home-manager modules
    extraSpecialArgs = { inherit system pkgs; };
  };
}
