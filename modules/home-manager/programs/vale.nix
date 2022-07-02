# Linter for prose: https://vale.sh
{ pkgs, ... }:

{
  home.packages = [ pkgs.unstable.vale ];

  home.file.".vale.ini".text = ''
    StylesPath = styles

    MinAlertLevel = suggestion
    Vocab = Base

    Packages = Google, proselint, write-good, Readability, Hugo

    [*]
    BasedOnStyles = Vale, Google, proselint, write-good, Readability
  '';
}
