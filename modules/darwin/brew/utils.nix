{ pkgs, ... }:

{
  homebrew = {
    casks = if pkgs.stdenv.hostPlatform.isAarch64 then [ ] else [ "authy" ];
    masApps = {
      "1Password 7 - Password Manager" = 1333542190;
      "Tailscale" = 1475387142;
      "Yubico Authenticator" = 1497506650;
    };
  };
}
