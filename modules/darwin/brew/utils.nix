{ pkgs, ... }:

{
  homebrew = {
    casks = if pkgs.stdenv.hostPlatform.isAarch64 then
      [ ]
    else [
      "authy"
      "1password" # 1Password 8 was released in May 2022
    ];
    masApps = {
      "1Password for Safari" = 1569813296;
      "Tailscale" = 1475387142;
      "Yubico Authenticator" = 1497506650;
    };
  };
}
