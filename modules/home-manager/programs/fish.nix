{ pkgs, ... }:

{
  programs = {
    fish = {
      enable = true;

      functions = {
        prompt_hostname = { body = "scutil --get LocalHostName"; };
      };

      loginShellInit = ''
        fish_add_path --move --prepend --path \
           $HOME/.nix-profile/bin \
           /nix/var/nix/profiles/default/bin \
           ${
             if pkgs.stdenv.hostPlatform.isAarch64 then
               "/opt/homebrew/bin"
             else
               "/usr/local/bin"
           } \
           /run/current-system/sw/bin # https://github.com/LnL7/nix-darwin/issues/122
      '';

      shellInit = ''
        # suppress default greeting
        set -U fish_greeting
      '';

      shellAliases = {
        ia = ''open -a "/Applications/iA Writer.app" '';
        ls = "exa";
      };
    };
  };
}
