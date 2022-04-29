{ pkgs, ... }:

{
  home.packages = [
    pkgs.unstable.bazelisk
    pkgs.unstable.bazel-buildtools
    pkgs.git
    pkgs.lcov
    pkgs.unstable.gh
    pkgs.unstable.pre-commit
    pkgs.unstable.yamllint
  ];

  programs = {
    jq.enable = true;
    fish.shellAliases = { bazel = "bazelisk"; };
  };
}
