{ pkgs, system, username, stateVersion, ... }:

{
  home = {
    inherit username stateVersion;
    homeDirectory = "/home/${username}";
  };
  programs.home-manager = { enable = true; };
  imports = [
    ../modules/home-manager/development.nix
    ../modules/home-manager/terminal.nix
    ../modules/home-manager/tools.nix
    ../modules/home-manager/programs/direnv.nix
    ../modules/home-manager/programs/fish.nix
    ../modules/home-manager/programs/home-manager.nix
    ../modules/home-manager/programs/neovim.nix
    ../modules/home-manager/programs/starship.nix
  ];
}
