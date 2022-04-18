{ pkgs, ... }:

{
  home.packages =
    [ pkgs.unstable.bazelisk pkgs.unstable.gh pkgs.jq pkgs.nixfmt ];

  programs = { jq.enable = true; };
}
