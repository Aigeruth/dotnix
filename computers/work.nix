{ pkgs, system, stateVersion, username, ... }:

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
        ../modules/home-manager/programs/1password.nix
        ../modules/home-manager/programs/direnv.nix
        ../modules/home-manager/programs/fish.nix
        ../modules/home-manager/programs/home-manager.nix
        ../modules/home-manager/programs/neovim.nix
        ../modules/home-manager/programs/starship.nix
        ../modules/home-manager/programs/vale.nix
      ];

      home.stateVersion = stateVersion;
    };
    # These are passed down to all home-manager modules
    extraSpecialArgs = { inherit system pkgs; };
  };
}
