{ pkgs, ... }:

{
  home-manager.users.stefan = {
    programs.emacs = {
      enable = true;
    };
  };
} 