{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    plugins = with pkgs.unstable.vimPlugins; [
      dracula-vim
      (nvim-treesitter.withPlugins (plugins: [
        plugins.tree-sitter-nix
      ]))
    ];

    vimAlias = true;

    withRuby = false;
    withPython3 = false;
    withNodeJs = false;

    package = pkgs.unstable.neovim-unwrapped;
    extraConfig = ''
      colorscheme dracula

      lua << EOF
        require'nvim-treesitter.configs'.setup {
          highlight = {
            enable = true,
          },
          indent = {
            enable = true,
          },
        }
      EOF
    '';
  };
}
