{ pkgs, ... }: {
  environment.shells = [ pkgs.fish ];
  environment.systemPackages = [ pkgs.fish ];
}
