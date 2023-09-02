{ config, pkgs, stateVersion, username, ... }:

{
  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
  };
  home-manager = {
    users.${username} = {
      imports = [
        ../modules/home-manager/development.nix
        ../modules/home-manager/terminal.nix
        ../modules/home-manager/tools.nix
        ../modules/home-manager/programs/1password.nix
        ../modules/home-manager/programs/direnv.nix
        ../modules/home-manager/programs/emacs.nix
        ../modules/home-manager/programs/fish.nix
        ../modules/home-manager/programs/home-manager.nix
        ../modules/home-manager/programs/neovim.nix
        ../modules/home-manager/programs/starship.nix
        ../modules/home-manager/programs/vale.nix
      ];
      home.packages = [ pkgs.ledger ];
      home.stateVersion = stateVersion;
    };
    # These are passed down to all home-manager modules
    extraSpecialArgs = { inherit pkgs; };
  };
  services.emacs = {
    enable = true;
    package = config.home-manager.users.${username}.programs.emacs.finalPackage;
    additionalPath = [ "${pkgs.ledger}/bin" "${pkgs.coreutils}/bin" ];
  };
}
