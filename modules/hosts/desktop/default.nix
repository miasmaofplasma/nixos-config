{ inputs, config, ... }:
let
  inherit (config.flake.modules) homeManager nixos;
  username = "miasmaofplasma";
in
{
  configurations.nixos.desktop.module = {
    imports = [
      inputs.hardware.nixosModules.common-cpu-amd
      ./_hardware.nix
      nixos.nvidia
      nixos.stackLinuxBase
      nixos.stackHyprland
      nixos.gaming
    ];

    primaryUser = username;
    system.stateVersion = "26.05";

    # Workaround: The AB13X USB Headset Adapter (001f:0b21) reports a narrow
    # hardware mixer range of -45 dB to 0 dB. PipeWire uses a cubic dB curve
    # (dB = 60 * log10(vol)), reaching -45 dB at ~17-20% and zeroing out the DAC.
    # Setting `api.alsa.ignore-dB = true` makes PipeWire treat the hardware mixer
    # as linear integer steps (0..11520) rather than cutting off at -45 dB,
    # keeping full hardware output at 100% while allowing smooth attenuation.
    services.pipewire.wireplumber.extraConfig."50-usb-ignore-db" = {
      "monitor.alsa.rules" = [
        {
          matches = [
            {
              "device.vendor.id" = "0x001f";
              "device.product.id" = "0x0b21";
            }
          ];
          actions = {
            update-props = {
              "api.alsa.ignore-dB" = true;
            };
          };
        }
      ];
    };

    home-manager.users.${username} = {
      imports = [ homeManager.rolesGamedev ];
      programs.home-manager.enable = true;
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "26.05";
      };
    };
  };
}
