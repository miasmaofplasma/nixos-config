{ ... }:
{
  flake.modules.homeManager.rolesGamedev =
    { pkgs, ... }:
    let
      dotnetSdk = pkgs.dotnetCorePackages.combinePackages [
        pkgs.dotnetCorePackages.sdk_10_0
        pkgs.dotnetCorePackages.sdk_8_0
      ];

      godot = pkgs.godot_4-mono.overrideAttrs (old: {
        dotnet-sdk = dotnetSdk;
      });
    in
    {
      home.packages = [
        godot
        dotnetSdk
      ];

      home.sessionVariables = {
        DOTNET_ROOT = "${dotnetSdk}/share/dotnet";
      };
    };
}
