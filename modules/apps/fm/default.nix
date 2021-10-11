{ pkgs, ... }:

{
  home-manager.users.stefan = {
    programs.broot = {
      enable = true;
    };
  };
}
