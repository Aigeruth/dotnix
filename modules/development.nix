{ pkgs, ... }:

{
  home.packages =
    [ pkgs.unstable.bazelisk pkgs.unstable.gh pkgs.unstable.pre-commit ];

  programs = {
    jq.enable = true;
    fish.shellAliases = { bazel = "bazelisk"; };
  };
}
