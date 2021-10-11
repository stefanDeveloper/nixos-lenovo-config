{ config, pkgs, ... }:

{
  home-manager.users.stefan = {
    programs.vscode = {
      enable = true;
    };
  };
}