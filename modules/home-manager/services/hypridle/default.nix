{ ... }:
{
  flake.modules.homeManager.servicesHypridle =
    { ... }:
    {
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            before_sleep_cmd = "noctalia msg session lock";
            # Hyprland >= 0.55 dispatch args are Lua: hl.dsp.dpms takes
            # { action = "on"|"off"|"toggle" }. The `action` field is
            # mandatory — any other or missing field falls back to TOGGLE,
            # which blanked the monitors right after every resume (regression
            # from `hyprctl dispatch dpms on` in the hyprland.lua migration).
            after_sleep_cmd = "pidof Hyprland >/dev/null && hyprctl dispatch 'hl.dsp.dpms({ action = \"on\" })' || { command -v niri >/dev/null 2>&1 && niri msg action power-on-monitors; }";
            lock_cmd = "noctalia msg session lock";
          };
        };
      };
    };
}
