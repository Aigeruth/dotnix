{ lib, pkgs, ... }: {
  home.packages = [ pkgs.unstable._1password pkgs.unstable._1password-gui ];
  programs.fish.interactiveShellInit = lib.mkAfter ''
    op completion fish | source
  '';
}
