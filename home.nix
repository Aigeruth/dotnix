{ pkgs, username, imports, ... }:

{
  home.packages = [
    pkgs.restic

    # unfree packages
    pkgs.unstable._1password
  ];

  inherit imports;

  # Let Home Manager install and manage itself.
  programs = { home-manager.enable = true; };
}
