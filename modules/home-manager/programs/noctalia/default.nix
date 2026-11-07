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

      # Plugin dependencies (e.g. special-workspaces IPC listener)
      home.packages = [
        pkgs.socat
      ];

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

          # Default session panel only offers lock_and_suspend, which blanks
          # outputs (DPMS off) before sleeping. On this NVIDIA setup the heads
          # never come back after S3 with that pre-blank (monitors stay
          # "no signal"). Plain suspend keeps outputs on through sleep and
          # still locks first via hypridle's before_sleep_cmd.
          "shell.session" = {
            actions = [
              { action = "lock"; }
              { action = "logout"; }
              { action = "suspend"; }
              { action = "reboot"; }
              { action = "shutdown"; }
            ];
          };

          bar.default = {
            start = [
              "launcher"
              "workspaces"
              "jamesfeeder/special-workspaces:special-workspaces"
            ];
          };
        };
      };
    };
}
