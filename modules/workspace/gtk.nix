{ pkgs, old, config, lib, inputs, ... }:
{
  home-manager.users.stefan = {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      theme = {
        name = "Ark-Dark";
        package = pkgs.arc-theme;
      };
      font = { name = "IBM Plex 12"; };
      gtk3 = {
        extraConfig = {
          gtk-cursor-theme-name = "Breeze";
        };
      };
    };
  };
}
