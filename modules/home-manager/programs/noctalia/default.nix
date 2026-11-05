{ inputs, ... }:
{
  flake.modules.homeManager.programsNoctalia =
    {
      config,
      pkgs,
      ...
    }:
    let
      colors = import ./_colors.nix {
        inherit inputs pkgs;
        catppuccin = config.profile.appearance.catppuccin;
      };
      pluginConfig = import ./_plugins.nix;
      settings =
        (import ./_settings-desktop.nix)
        // (import ./_settings-session.nix { avatar = config.profile.avatar; })
        // (import ./_settings-ui.nix {
          uiFont = config.profile.appearance.fonts.ui.family;
          monospaceFont = config.profile.appearance.fonts.monospace.family;
        });
    in
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      home.file.".local/share/wallpapers".source = config.profile.wallpapers;

      programs.noctalia = {
        enable = true;
        package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
        systemd.enable = true;
        settings = {
          wallpaper = {
            enabled = true;
            directory = "${config.home.homeDirectory}/.local/share/wallpapers";
            default.path = "${config.profile.wallpapers}/snowy-mountain.jpg";
          };
        };
      };
    };
}
