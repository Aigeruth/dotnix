{ pkgs, ... }:

{
  home.packages = [ pkgs.unstable.bazelisk pkgs.unstable.gh ];

  programs = { jq.enable = true; };
}
