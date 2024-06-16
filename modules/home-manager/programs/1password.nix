{ lib, pkgs, ... }: {
  programs = {
    fish.interactiveShellInit = lib.mkAfter ''
      op completion fish | source
    '';
    _1password-shell-plugins = {
      enable = true;
      package = null;
      plugins = [ pkgs.unstable.gh ];
    };
  };
}
