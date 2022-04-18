{ pkgs, ... }:

{
  home.packages = [
    pkgs.bat
    pkgs.coreutils
    pkgs.exa
    pkgs.fd
    pkgs.ripgrep
    pkgs.vgrep
    pkgs.wget
  ];
}
