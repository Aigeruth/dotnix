{ pkgs, ... }:

{
  nix.package = pkgs.nixFlakes;

  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "right";
  system.defaults.alf.globalstate = 1;
  system.defaults.alf.allowsignedenabled = 1;

  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
