
{ pkgs, ... }:

{
  home-manager.users.stefan = {
    home.packages = with pkgs; [
      vlc
      mpv
    ];
  };
}