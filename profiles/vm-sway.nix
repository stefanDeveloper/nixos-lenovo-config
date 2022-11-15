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

    themes
    overlay

    monitoring
    fm
    tools

    git

    workspace
    cursor
    gtk
    qt
    gnome

    apps
    dev
    reading
    editor
    zsh
    alacritty

    vm-shared
    sway
    #x11
    #i3
  ];
}
