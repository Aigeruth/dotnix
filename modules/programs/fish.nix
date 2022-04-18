{ pkgs, ... }:

{
  home.packages = [
    pkgs.fish
  ];

  programs = {
    fish = {
      enable = true;

      functions = {
        prompt_hostname = {
          body = "scutil --get LocalHostName";
        };
      };

      loginShellInit = ''
        if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
          fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        end
      '';

      shellInit = ''
        # suppress default greeting
        set -U fish_greeting
      '';

      shellAliases = {
        ia = ''open -a "/Applications/iA Writer.app" '';
      };

      plugins = [{
        name = "foreign-env";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-foreign-env";
          rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
          sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
        };
      }];
    };
  };
}
