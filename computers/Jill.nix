{ pkgs, system, stateVersion, ... }:

{
  users.users.nagyg = {
    name = "nagyg";
    home = "/Users/nagyg";
  };
  home-manager = {
    users.nagyg = {
      imports = [
        ../modules/home-manager/development.nix
        ../modules/home-manager/terminal.nix
        ../modules/home-manager/tools.nix
        ../modules/home-manager/programs/emacs.nix
        ../modules/home-manager/programs/fish.nix
        ../modules/home-manager/programs/home-manager.nix
        ../modules/home-manager/programs/neovim.nix
      ];

      home.stateVersion = stateVersion;
    };
    # These are passed down to all home-manager modules
    extraSpecialArgs = { inherit system pkgs; };
  };
}
