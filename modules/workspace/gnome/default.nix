{pkgs, ...}:
{
    services.gnome.games.enable = false;
    environment.systemPackages = with pkgs; [
      # GNOME
      gnome3.gnome-tweaks
    ];
    environment.gnome.excludePackages = with pkgs; [
      gnome3.gnome-music
      gnome3.epiphany
      gnome3.yelp
      gnome3.gnome-maps
      gnome3.geary
    ];
}