{ pkgs, config, lib, inputs, ... }:

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

      font = {
        name = with config.themes.fonts; "${main.family} ${toString main.size}";
      };

      gtk3 = {
        bookmarks = [
          "file:///home/stefan/projects Projects"
          "file:///home/stefan/Seafile" "Seafile"
          "file:///home/stefan/Nextcloud" "Nextcloud"
        ];
      };
    };

    home.sessionVariables.GTK_THEME = "Generated";
  };
}
