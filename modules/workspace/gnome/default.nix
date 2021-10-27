{pkgs, ...}:
{
    programs.dconf.enable = true;
    services.dbus.packages = [ pkgs.gnome3.dconf ];
    services.udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];
    services.gnome.games.enable = false;
    environment.systemPackages = with pkgs; [
      # GNOME
      gnome.gnome-tweaks
      # extensions
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-panel
      
      gnome3.adwaita-icon-theme
    ];
    environment.gnome.excludePackages = with pkgs; [ 
      # gnome.cheese 
      # gnome.gnome-terminal 
      gnome-photos 
      gnome.gedit 
      epiphany
      gnome.gnome-characters
      gnome.totem
      gnome-tour

      gnome.gnome-music
      gnome.yelp
      gnome.gnome-maps
      gnome.geary
    ];
}