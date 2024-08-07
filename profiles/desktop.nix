{ inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./base.nix

    workspace
    cursor
    gtk
    qt
    gnome

    virtualisation

    apps
    messaging
    web
    media
    dev
    office
    reading
    editor
    zsh
    alacritty
  ];
}
