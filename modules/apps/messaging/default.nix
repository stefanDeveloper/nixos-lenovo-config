{ pkgs, ... }:

{
  home-manager.users.stefan = {
    home.packages = with pkgs; [
      slack
      discord
      element-desktop

      tdesktop
    ];
  };
}