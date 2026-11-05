{ ... }:
{
  flake.modules.homeManager.programsZsh =
    {
      lib,
      pkgs,
      ...
    }:
    {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          ff = "fastfetch";
          open = lib.mkIf pkgs.stdenv.hostPlatform.isLinux "xdg-open";
          nixos-rebuild = "sudo nixos-rebuild";
          rebuild = "sudo nixos-rebuild switch --flake /home/miasmaofplasma/nixos-config";

          # git
          gaa = "git add --all";
          gcam = "git commit --all --message";
          gcl = "git clone";
          gco = "git checkout";
          ggl = "git pull";
          ggp = "git push";

          lg = "lazygit";

          pt = "podman-tui";

          repo = "cd $HOME/Documents/repositories";
          temp = "cd $HOME/Downloads/temp";

          v = "nvim";
          vi = "nvim";
          vim = "nvim";

          ls = "eza --icons always"; # default view
          ll = "eza -bhl --icons --group-directories-first"; # long list
          la = "eza -abhl --icons --group-directories-first"; # all list
          lt = "eza --tree --level=2 --icons"; # tree
        };
        initContent = ''
          # bindings
          bindkey -e
          bindkey '^H' backward-delete-word
          bindkey '^[[1;5C' forward-word
          bindkey '^[[1;5D' backward-word

          # open commands in $EDITOR with C-e
          autoload -z edit-command-line
          zle -N edit-command-line
          bindkey "^v" edit-command-line

        '';
      };
    };
}
