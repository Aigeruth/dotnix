{ pkgs, ... }:

{
  home.packages = [ pkgs.unstable.restic pkgs.rsync pkgs.unstable._1password ];
}
