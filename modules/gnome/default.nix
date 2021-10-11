{
    services.gnome.games.enable = false;
    environment.systemPackages = [
      # GNOME
      gnome3.gnome-tweaks
    ];
}