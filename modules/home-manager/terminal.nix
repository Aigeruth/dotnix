{ pkgs, ... }:

{
  home.packages =
    [ pkgs.coreutils pkgs.eza pkgs.fd pkgs.ripgrep pkgs.vgrep pkgs.wget ]
    ++ (if pkgs.stdenv.hostPlatform.isDarwin then
      [ pkgs.pinentry_mac ]
    else
      [ ]);

  programs = {
    bat = {
      enable = true;
      config = { theme = "Dracula"; };
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
    gpg = {
      enable = true;
      settings = {
        "auto-key-locate" = "keyserver";
        "keyserver" = "hkps://hkps.pool.sks-keyservers.net";
        "keyserver-options" = "no-honor-keyserver-url";
        "personal-cipher-preferences" = "AES256 AES192 AES CAST5";
        "personal-digest-preferences" = "SHA512 SHA384 SHA256 SHA224";
        "default-preference-list" =
          "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
        "cert-digest-algo" = "SHA512";
        "s2k-cipher-algo" = "AES256";
        "s2k-digest-algo" = "SHA512";
        "charset" = "utf-8";
        "fixed-list-mode" = true;
        "no-comments" = true;
        "no-emit-version" = true;
        "keyid-format" = "0xlong";
        "list-options" = "show-uid-validity";
        "verify-options" = "show-uid-validity";
        "with-fingerprint" = true;
        "use-agent" = true;
        "require-cross-certification" = true;
      };
    };
    kitty = {
      enable = true;
      font = {
        name = "iM Writing Mono S Regular Nerd Font Complete";
        size = 10;
      };
      package = pkgs.unstable.kitty;
      settings = {
        enable_audio_bell = false;
        update_check_interval = 0;
      };
    };
    tmux = {
      enable = true;
      clock24 = true;
      plugins = with pkgs.tmuxPlugins; [{
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-fahrenheit false
          set -g @dracula-plugins "cpu-usage ram-usage time"
        '';
      }];
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
