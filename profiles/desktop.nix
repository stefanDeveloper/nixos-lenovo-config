{ inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./base.nix

    workspace

    virtualisation

    apps
    fm
    messaging
    web
    media
    dev
    office
    zsh
  ];
}
