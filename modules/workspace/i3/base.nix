{ pkgs, lib, config, inputs, nixpkgs-unstable, ... }:

{
  # links /libexec from derivations to /run/current-system/sw 
  environment.pathsToLink = [ "/libexec" ];
  # i3 settings
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      configFile = ./config/custom;
    };
  };

  services.displayManager = {
    defaultSession = "none+i3";
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

    nixpkgs-unstable.keepmenu # testing
    xdotool

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
      "i3status" = {
        source = ./i3status.conf;
        target = ".config/i3/i3status.conf";
      };
      "nitrogen" = {
        target = ".config/nitrogen/bg-saved.cfg";
        text = ''
          [xin_-1]
          file=${inputs.nixos-artwork}/wallpapers/nix-wallpaper-dracula.png
          mode=1
          bgcolor=#000000
        '';
      };
      "keepmenu" = {
        target = ".config/keepmenu/config.ini";
        text = ''
          [dmenu]
          # Note that dmenu_command can contain arguments as well
          dmenu_command = rofi -lines 12 -padding 18 -width 60 -location 0 -dmenu -columns 3 -font 'IBM Plex Sans 12'

          [dmenu_passphrase]
          ## Obscure password entry.
          obscure = True
          obscure_color = #303030

          [database]
          database_1 = ~/Documents/KeePassX/private_db.kdbx

          pw_cache_period_min = 720

          type_library = xdotool

          ## Set the global default
          autotype_default = {PASSWORD}{ENTER}
          autotype_default_2 = {TOTP}{ENTER}
        '';
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
