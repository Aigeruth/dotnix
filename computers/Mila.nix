{ pkgs, system, stateVersion, ... }:

{
  users.users.aige = {
    name = "aige";
    home = "/Users/aige";
  };
  home-manager = {
    users.aige = {
      imports = [
        ../modules/development.nix
        ../modules/finance.nix
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

