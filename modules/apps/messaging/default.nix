{ pkgs, ... }:

{
  home-manager.users.stefan = {
    home.packages = with pkgs; [
      slack
      discord
      element-desktop

      tdesktop
      threema-desktop
      signal-desktop
    ];
  };
}