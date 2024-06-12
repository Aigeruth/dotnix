{ inputs, lib, pkgs, ... }: {
  imports = [ inputs._1password-shell-plugins.hmModules.default ];
  home.packages = [ pkgs.unstable._1password pkgs.unstable._1password-gui ];
  programs = {
    fish.interactiveShellInit = lib.mkAfter ''
      op completion fish | source
    '';
    _1password-shell-plugins = {
      enable = true;
      plugins = with pkgs; [ gh ];
    };
  };
}
