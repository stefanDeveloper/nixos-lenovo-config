{ config, pkgs, lib, ... }:

{
  programs.browserpass.enable = true;

  home-manager.users.stefan = {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        darkreader
        ublock-origin
        startpage-private-search
        momentumdash 
      ];
      profiles.default = {
        id = 0;
        settings = {
          "extensions.autoDisableScopes" = 0;

          "browser.search.defaultenginename" = "Startpage.com - English";
          "browser.search.selectedEngine" = "Startpage.com - English";
          "browser.urlbar.placeholderName" = "Startpage.com - English";
          "browser.search.region" = "US";
          "browser.startup.homepage" = "about:blank";
          "browser.newtabpage.enabled" = true;

          "services.sync.username" = "stefan-machmeier@outlook.com";

          "browser.toolbars.bookmarks.visibility" = "always";

          "browser.uidensity" = 1;
          "browser.search.openintab" = true;

          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "browser.theme.toolbar-theme" = 0;
          "browser.theme.content-theme" = 0;

          "signon.rememberSignons" = true;
        };
      };
    };
  };
}