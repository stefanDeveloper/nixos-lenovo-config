{ inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./base.nix

    workspace
    ssh

    virtualisation

    apps
    messaging
    web
    torrent
    media
    dev
    office
    shell
  ];
}
