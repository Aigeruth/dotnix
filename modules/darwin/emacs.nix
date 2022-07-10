{ config, pkgs, username, ... }:

{
  services.emacs = {
    enable = true;
    package = config.home-manager.users.${username}.programs.emacs.finalPackage;
  };
}
