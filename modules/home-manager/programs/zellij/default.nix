{ ... }:
{
  flake.modules.homeManager.programsZellij =
    { ... }:
    {
      programs.zellij = {
        enable = true;
        extraConfig = builtins.readFile ./config.kdl;
      };
      catppuccin.zellij.enable = false;
    };
}
