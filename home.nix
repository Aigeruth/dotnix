{ home-manager, pkgs, pkgs-unstable, username, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "aige";
  home.homeDirectory = "/Users/aige";
  home.packages = [
    pkgs.bat
    pkgs.bazelisk
    pkgs.fish
    pkgs.jq
    pkgs.nixfmt
    pkgs.restic
    pkgs.ripgrep
    pkgs.vgrep
    pkgs.wget

    # unfree packages
    pkgs-unstable._1password
  ];

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
  };
}
