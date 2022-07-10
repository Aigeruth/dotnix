{ config, pkgs, ... }:

{
  services.emacs = {
    enable = true;
    package = config.home-manager.users.aige.programs.emacs.finalPackage;
  };
}
