{ inputs, config, ... }:
let
  inherit (config.flake.modules) nixos;
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

    home-manager.users.${username} = {
      programs.home-manager.enable = true;
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "26.05";
      };
    };
  };
}
