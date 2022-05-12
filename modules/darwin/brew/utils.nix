{ pkgs, ... }:

{
  homebrew = {
    casks = [
      "1password" # 1Password 8 was released in May 2022
    ] ++ (if pkgs.stdenv.hostPlatform.isAarch64 then [ ] else [ "authy" ]);
    masApps = {
      "1Password for Safari" = 1569813296;
      "Tailscale" = 1475387142;
      "Yubico Authenticator" = 1497506650;
    };
  };
}
