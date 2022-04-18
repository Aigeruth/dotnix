{ pkgs, ... }:

{
  home.packages = [
    pkgs.bat
    pkgs.exa
    pkgs.fd
    pkgs.ripgrep
    pkgs.vgrep
    pkgs.wget
  ];
}
