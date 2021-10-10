{ config, pkgs, lib, ... }:

{
  programs.browserpass.enable = true;

  home-manager.users.stefan = {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox;

      profiles.default = {
        id = 0;
        settings = {
          "extensions.autoDisableScopes" = 0;

          "browser.search.defaultenginename" = "Google";
          "browser.search.selectedEngine" = "Google";
          "browser.urlbar.placeholderName" = "Google";
          "browser.search.region" = "US";

          "browser.uidensity" = 1;
          "browser.search.openintab" = true;
        };
      };
    };
  };
}