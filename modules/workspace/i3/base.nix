{ pkgs, lib, config, ... }:

{
  # links /libexec from derivations to /run/current-system/sw 
  environment.pathsToLink = [ "/libexec" ];
  # Support settings to be stored
  programs.dconf.enable = true;
  # i3 settings
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
      configFile = ./config/custom;
    };
  };

  services.compton.enable = true;

  environment.systemPackages = with pkgs; [
    xorg.xrandr       # display manager
    dmenu             # app launcher
    nitrogen          # wallpaper
    rofi              # app launcher
    dunst             # notification
    betterlockscreen  # lockscreen
    i3lock-pixeled    # i3lock
    i3status
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
      "i3status" = {
        source = ./i3status.conf;
        target = ".config/i3/i3status.conf";
      };
    };
  };
}
