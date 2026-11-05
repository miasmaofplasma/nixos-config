{ ... }:
{
  flake.modules.homeManager.rolesGamedev =
    { pkgs, ... }:
    let
      dotnetSdk = pkgs.dotnetCorePackages.combinePackages [
        pkgs.dotnetCorePackages.sdk_10_0
        pkgs.dotnetCorePackages.sdk_8_0
      ];
    in
    {
      home.packages = [
        pkgs.godot_4-mono
        dotnetSdk
      ];

      home.sessionVariables = {
        DOTNET_ROOT = "${dotnetSdk}/share/dotnet";
      };
    };
}
