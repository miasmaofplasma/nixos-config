{ ... }:
{
  flake.modules.homeManager.programsZellij =
    { ... }:
    {
      programs.zellij = {
        enable = true;
      };
      catppuccin.zellij.enable = true;
    };
}
