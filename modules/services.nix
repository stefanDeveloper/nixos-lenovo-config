{pkgs,...}:

{
  services = {
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      # Enable the GNOME Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      # Configure keymap in X11
      layout = "us,de";
      # xkbOptions = "altwin:alt_win";
    };
    
    gnome.games.enable = false;

    # Enable CUPS to print documents.
    # Currently not working
    printing.enable = true;
    printing.drivers = with pkgs; [ canon-cups-ufr2 ];
  };
}