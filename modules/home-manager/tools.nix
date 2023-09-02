{ pkgs, ... }:

{
  home.packages = [ pkgs.unstable.restic pkgs.rsync ];
}
