{ pkgs, lib, config, ... }:
{
  services.xserver = {
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  services.compton.enable = true;

  environment.systemPackages = with pkgs; [
    xrandr-invert-colors
    dmenu
    nitrogen
    rofi
    dunst
    betterlockscreen
    i3lock-pixeled
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
