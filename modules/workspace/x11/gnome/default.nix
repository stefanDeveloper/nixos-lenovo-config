{pkgs, ...}:
{
  services = {
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      # Enable the GNOME Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
  
  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gnome3.dconf ];
  services.udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];
  services.gnome.games.enable = false;
  environment.systemPackages = with pkgs; [
    # GNOME
    gnome.gnome-tweaks
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