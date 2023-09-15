{ pkgs, ... }:

{
  # Enable a low-level configuration system and settings
  # management tool. Its main purpose is to provide a back end
  # to GSettings on platforms that don't already have
  # configuration storage systems. It is part of GNOME 3 and is
  # a replacement for GConf
  programs.dconf.enable = true;

  services = {
    # Packages whose D-Bus configuration files should be included
    # in the configuration of the D-Bus system-wide or
    # session-wide message bus
    dbus.packages = with pkgs; [ dconf ];

    gnome = {
      core-os-services.enable = true;
      core-utilities.enable = true;
      gnome-settings-daemon.enable = true;
      glib-networking.enable = true;
    };
  };

  environment.sessionVariables.XDG_CURRENT_DESKTOP = "X-Generic";

  home-manager.users.stefan = {
    dconf.settings = {
      "org/gnome/nautilus/icon-view" = {
        captions = [ "size" "date_modified" "none" ];
      };

      "org/gnome/nautilus/list-view" = {
        default-column-order = [
          "name"
          "size"
          "type"
          "owner"
          "group"
          "permissions"
          "where"
          "date_modified"
          "date_modified_with_time"
          "date_accessed"
          "recency"
          "starred"
          "detailed_type"
        ];
        default-visible-columns = [ "name" "size" "date_modified" "starred" ];
      };

      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "list-view";
        executable-text-activation = "display";
        search-filter-time-type = "last_modified";
        search-view = "list-view";
        show-image-thumbnails = "always";
        thumbnail-limit = 10;
      };

      "org/gnome/desktop/interface" = { cursor-theme = "default"; };

      "org/gnome/evince/default" = { inverted-colors = true; };
    };
  };
}
