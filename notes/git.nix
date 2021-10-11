{ config, pkgs, ... }:

{
  home-manager.users.stefan = {
    programs.git = {
      enable = true;
      userName  = "Stefan Machmeier";
      userEmail = "stefan-machmeier@outlook.com";
    };
  };
}
