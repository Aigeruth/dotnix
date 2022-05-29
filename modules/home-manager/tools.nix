{ pkgs, ... }:

{
  home.packages = [ pkgs.unstable.restic pkgs.rsync pkgs._1password ];
}
