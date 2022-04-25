{ pkgs, ... }:

{
  home.packages = [ pkgs.unstable.rnix-lsp pkgs.unstable.nixfmt ];

  programs.neovim = {
    enable = true;

    plugins = with pkgs.unstable.vimPlugins; [
      ale
      dracula-vim
      (nvim-treesitter.withPlugins (plugins: [ plugins.tree-sitter-nix ]))
    ];

    vimAlias = true;

    withRuby = false;
    withPython3 = false;
    withNodeJs = false;

    package = pkgs.unstable.neovim-unwrapped;
    extraConfig = ''
      colorscheme dracula

      let g:ale_completion_enabled = 1
      let g:ale_fix_on_save = 1
      let g:ale_fixers = {
      \  '*': ['remove_trailing_lines', 'trim_whitespace'],
      \  'javascript': ['eslint', 'prettier'],
      \  'nix': ['nixfmt'],
      \  'python': ['black']
      \}

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
