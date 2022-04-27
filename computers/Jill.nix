{ pkgs, system, stateVersion, ... }:

{
  users.users.nagyg = {
    name = "nagyg";
    home = "/Users/nagyg";
  };
  home-manager = {
    users.nagyg = {
      imports = [
        ../modules/development.nix
        ../modules/terminal.nix
        ../modules/tools.nix
        ../modules/programs/fish.nix
        ../modules/programs/home-manager.nix
        ../modules/programs/neovim.nix
        ../modules/programs/emacs.nix
      ];

      home.stateVersion = stateVersion;
    };
    # These are passed down to all home-manager modules
    extraSpecialArgs = { inherit system pkgs; };
  };
}
