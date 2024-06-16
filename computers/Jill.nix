{ pkgs, system, username, stateVersion, shell-plugins, ... }:

{
  home = {
    inherit username stateVersion;
    homeDirectory = "/home/${username}";
  };
  imports = [
    shell-plugins.hmModules.default
    ../modules/home-manager/development.nix
    ../modules/home-manager/terminal.nix
    ../modules/home-manager/tools.nix
    ../modules/home-manager/programs/1password.nix
    ../modules/home-manager/programs/emacs.nix
    ../modules/home-manager/programs/fish.nix
    ../modules/home-manager/programs/home-manager.nix
    ../modules/home-manager/programs/neovim.nix
    ../modules/home-manager/programs/starship.nix
  ];
  programs = {
    home-manager = { enable = true; };
    # 1Password is installed via apt.
    git.extraConfig.gpg.ssh.program = "/opt/1Password/op-ssh-sign";
  };
}
