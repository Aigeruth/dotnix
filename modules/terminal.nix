{ pkgs, ... }:

{
  home.packages = [
    pkgs.coreutils
    pkgs.exa
    pkgs.fd
    pkgs.ripgrep
    pkgs.vgrep
    pkgs.wget
  ];

  programs.bat = {
    enable = true;
    config = {
      theme = "Dracula";
    };
  };
}
