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
    security
    locale
    home
    users
    us-de

    themes
    overlay
    mail

    monitoring
    fm
    tools
    pentest

    git
  ];
}
