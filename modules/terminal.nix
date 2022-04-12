{ pkgs, ... }:

{
  home.packages = [
    pkgs.bat
    pkgs.exa
    pkgs.fish
    pkgs.ripgrep
    pkgs.vgrep
    pkgs.wget
  ];
}
