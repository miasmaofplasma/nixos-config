{ inputs, ... }:
{
  flake.modules.homeManager.programsNeovim =
    {
      config,
      pkgs,
      ...
    }:
    {
      programs.neovim = {
        enable = true;
        package = pkgs.neovim-unwrapped;
        defaultEditor = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = false;

        extraPackages = with pkgs; [
          bash-language-server
          black
          csharp-ls
          eslint
          gcc
          gopls
          gotools
          lua-language-server
          markdownlint-cli
          marksman
          nixd
          nixfmt
          prettier
          pyright
          ruff
          rust-analyzer
          shellcheck
          shfmt
          stylua
          tflint
          tofu-ls
          tree-sitter
          typescript-language-server
          yaml-language-server
        ];
      };

      xdg.configFile."nvim".source = inputs.nvim-config;

      home.sessionVariables = {
        CATPPUCCIN_FLAVOR = config.catppuccin.flavor;
      };
    };
}
