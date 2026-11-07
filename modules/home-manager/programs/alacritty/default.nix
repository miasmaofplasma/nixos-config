{ ... }:
{
  flake.modules.homeManager.programsAlacritty =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.alacritty = {
        enable = true;
        settings = {
          general = {
            live_config_reload = true;
          };

          terminal.shell = {
            program = "${pkgs.bash}/bin/bash";
            args = [
              "-c"
              ''
                sessions=$(${pkgs.zellij}/bin/zellij list-sessions -s -n 2>/dev/null)
                count=$(echo "$sessions" | grep -v '^$' | wc -l)

                if [ "$count" -eq 0 ]; then
                  exec ${pkgs.zellij}/bin/zellij attach -c terminal
                elif [ "$count" -eq 1 ]; then
                  exec ${pkgs.zellij}/bin/zellij attach "$sessions"
                else
                  choice=$(printf "%s\n[+ Create new session]\n" "$sessions" | ${pkgs.fzf}/bin/fzf --prompt="Select Zellij session: " --height=40% --reverse)
                  if [ "$choice" = "[+ Create new session]" ] || [ -z "$choice" ]; then
                    exec ${pkgs.zellij}/bin/zellij
                  else
                    exec ${pkgs.zellij}/bin/zellij attach "$choice"
                  fi
                fi
              ''
            ];
          };

          window = {
            decorations = if pkgs.stdenv.hostPlatform.isDarwin then "buttonless" else "full";
            dynamic_title = false;
            opacity = 0.85;
            dynamic_padding = true;
            dimensions = {
              columns = 170;
              lines = 45;
            };
            padding = {
              x = 5;
              y = 1;
            };
          };

          scrolling = {
            history = 10000;
            multiplier = 3;
          };

          font = {
            size = config.profile.appearance.fonts.terminal.size;
            normal = {
              family = config.profile.appearance.fonts.terminal.family;
              style = "Regular";
            };
            bold = {
              family = config.profile.appearance.fonts.terminal.family;
              style = "Bold";
            };
            italic = {
              family = config.profile.appearance.fonts.terminal.family;
              style = "Italic";
            };
            bold_italic = {
              family = config.profile.appearance.fonts.terminal.family;
              style = "Bold Italic";
            };
          };

          selection = {
            semantic_escape_chars = '',│`|:"' ()[]{}<>'';
            save_to_clipboard = true;
          };
        };
      };
    };
}
