{ ... }:
{
  flake.modules.homeManager.scripts =
    {
      pkgs,
      lib,
      ...
    }:
    {
      home.file = {
        ".local/bin" = {
          recursive = true;
          source = ./bin;
        };
      };

      home.sessionPath = [ "$HOME/.local/bin" ];
    };
}
