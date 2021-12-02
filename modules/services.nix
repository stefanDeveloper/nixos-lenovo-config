{pkgs,...}:

{
  services = {
    xserver = {
      # Configure keymap in X11
      layout = "us,de";
    };
    
    # Enable CUPS to print documents.
    # Currently not working
    printing.enable = true;
    printing.drivers = with pkgs; [ canon-cups-ufr2 ];
  };
}