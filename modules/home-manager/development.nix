{ pkgs, ... }:

{
  home.packages = [
    pkgs.unstable.bazelisk
    pkgs.unstable.bazel-buildtools
    pkgs.lcov
    pkgs.unstable.gh
    pkgs.mosh
    pkgs.unstable.pre-commit
    pkgs.unstable.yamllint
  ];

  programs = {
    jq.enable = true;
    fish.shellAliases = { bazel = "bazelisk"; };

    git = {
      enable = true;
      userName = "Gabor Nagy";
      userEmail = "mail@aigeruth.hu";
    };
  };
}
