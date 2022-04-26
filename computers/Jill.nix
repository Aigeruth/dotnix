{ pkgs, system, stateVersion, ... }:

{
  users.users.nagyg = {
    name = "nagyg";
    home = "/Users/nagyg";
  };
  home-manager = {
    # users.nagyg = import ./home.nix;
    users.nagyg = {
      imports = [
        ../modules/development.nix
        ../modules/terminal.nix
        ../modules/tools.nix
        ../modules/programs/fish.nix
        ../modules/programs/neovim.nix
      ];
    };
    # These are passed down to all home-manager modules
    extraSpecialArgs = { inherit system pkgs stateVersion; };
  };
}
