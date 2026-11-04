{ lib, pkgs, ... }:
{
  flake.modules.nixos.nvidia =
    { config, ... }:
    {
      # Enable OpenGL / Hardware graphics acceleration
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      # Load nvidia driver for Xorg and Wayland
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        # Modesetting is required for Wayland compositors (Hyprland, Niri, Mango, etc.)
        modesetting.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend fails.
        # Enable this if you have graphical corruption issues or sleep issues.
        powerManagement.enable = false;
        powerManagement.finegrained = false;

        # Use the NVidia open source kernel module (supported on Turing+ such as RTX 4080 Super).
        open = true;

        # Enable the Nvidia settings menu
        nvidiaSettings = true;

        # Select the appropriate driver version for your specific GPU.
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };

      # Environment variables required for smooth Wayland / Hyprland on Nvidia
      environment.sessionVariables = {
        # Tells Electron/Chromium apps to use Wayland
        NIXOS_OZONE_WL = "1";
        # Hardware video acceleration
        LIBVA_DRIVER_NAME = "nvidia";
        # Force GBM backend for Wayland
        GBM_BACKEND = "nvidia-drm";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      };
    };
}
