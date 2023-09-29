{ pkgs, ... }:

{
  nix.package = pkgs.nixFlakes;

  system = {
    defaults = {
      dock.autohide = true;
      dock.orientation = "right";
      alf.globalstate = 1;
      alf.allowsignedenabled = 1;
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    stateVersion = 4;
  };

  services.nix-daemon.enable = true;

}
