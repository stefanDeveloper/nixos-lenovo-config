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
    
    themes
    overlay

    monitoring
    fm
    tools
    pentest

    git
  ];
}