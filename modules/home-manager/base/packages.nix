{ inputs, ... }:
{
  flake.modules.homeManager.base =
    {
      lib,
      pkgs,
      ...
    }:
    {
      systemd.user.startServices = lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) "sd-switch";

      home.packages =
        with pkgs;
        [
          bat
          dig
          eza
          fd
          firefox
          github-copilot-cli
          inputs.omp.packages.${pkgs.stdenv.hostPlatform.system}.omp
          jq
          nh
          nodejs
          opencode
          pipenv
          podman-compose
          podman-tui
          python3
          ripgrep
          telegram-desktop
          unzip
          wl-clipboard
          zellij
        ]
        ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
          anki-bin
          hidden-bar
          mos
          podman
          raycast
        ]
        ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [
          anki
          tesseract
        ];
    };
}
