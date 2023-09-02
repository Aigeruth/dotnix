{ pkgs, ... }:

{
  homebrew = {
    casks = [ ]
      ++ (if pkgs.stdenv.hostPlatform.isAarch64 then [ ] else [ "authy" ]);
    masApps = {
      "Tailscale" = 1475387142;
      "Yubico Authenticator" = 1497506650;
    };
  };
}
