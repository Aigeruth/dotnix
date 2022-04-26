{ pkgs, ... }:

{
  nix.package = pkgs.nixFlakes;

  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "right";

  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
