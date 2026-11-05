{ inputs, ... }:
{
  flake.modules.homeManager.base =
    {
      lib,
      pkgs,
      ...
    }:
    {
      systemd.user.startServices = "sd-switch";

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
          pipenv
          podman-compose
          podman-tui
          python3
          ripgrep
          telegram-desktop
          unzip
          wl-clipboard
          zellij
          anki
          tesseract
        ];
    };
}
