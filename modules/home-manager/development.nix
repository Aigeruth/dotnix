{ pkgs, ... }:

{
  home.packages = [
    pkgs.unstable.bazelisk
    pkgs.unstable.bazel-buildtools
    pkgs.lcov
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
      extraConfig = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingKey =
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJtijXztr3oTWTcEfeFAx3ND9TyCbfoq0q8r5mnZbidr";
      };
    };
    gh = {
      enable = true;
      package = pkgs.unstable.gh;
    };
  };
}
