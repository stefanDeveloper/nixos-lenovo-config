{ inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    inputs.home-manager.nixosModules.home-manager

    hardware
    boot
    system
    network
    nix
    nixpkgs
    services
    locale
    home
    users
    us-de
    mail

    monitoring
    fm
    tools
    pentest

    git
  ];
}