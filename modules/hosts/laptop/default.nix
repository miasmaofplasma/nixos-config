{ inputs, config, ... }:
let
  inherit (config.flake.modules) nixos;
  username = "miasmaofplasma";
in
{
  configurations.nixos.laptop.module = {
    imports = [
      #inputs.hardware.nixosModules.asus-ga402x-nvidia
      ./_hardware.nix
      nixos.stackLinuxBase
      nixos.stackHyprland
      nixos.gaming
    ];

    # FIXME: reboot=efi hangs on this AMD X570-E board
    #boot.kernelParams = [ "reboot=acpi" ];

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
