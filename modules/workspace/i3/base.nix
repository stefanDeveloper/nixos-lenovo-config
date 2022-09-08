{ pkgs, lib, config, ... }:

{
  # links /libexec from derivations to /run/current-system/sw 
  environment.pathsToLink = [ "/libexec" ];
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
    xorg.xrandr # display manager
    dmenu # app launcher
    nitrogen # wallpaper
    rofi # app launcher
    dunst # notification
    # multilockscreen   # lockscreen, outdated and merged with Betterlockscreen
    betterlockscreen
    feh
    imagemagick
    xorg.xdpyinfo
    xorg.xrdb
    xorg.xset

    i3lock-pixeled # i3lock
    i3status # status bar
    flameshot # screenshot capture
    xautolock # autolock inactivity
    xidlehook # autolock fetch to allow videos, music without locking
    libnotify # notify system
    # Under investigation, don't know if it solves the problem
    lxappearance
    gtkmm2 # for nitrogen
    gnome-icon-theme # for nitrogen
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
      ".xinitrc" = {
        text = ''
          # set desktop background with custom effect
          # betterlockscreen -w dim only run that if you want to use the same background as betterlockscreen

          # Alternative (set last used background)
          # source ~/.fehbg
          nitrogen --restore &
        '';
      };
    };
  };
}
