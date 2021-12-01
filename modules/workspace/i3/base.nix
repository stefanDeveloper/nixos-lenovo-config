{ pkgs, lib, config, ... }:
{
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };
   
    displayManager = {
        defaultSession = "none+i3";
    };
    
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  services.compton.enable = true;

  environment.systemPackages = with pkgs; [
    xorg.xrandr
    dmenu
    nitrogen
    rofi
    dunst
    betterlockscreen
    i3lock
    polybar
  ];

  home-manager.users.stefan = {
    home.file = {
      ".compton.conf" = { source = ./compton.conf; };
      "dunst" = {
        source = ./dunst;
        target = ".config/dunst";
        recursive = true;
      };
      "rofi" = {
        source = ./rofi;
        target = ".config/rofi";
      };
    };
  };
}
