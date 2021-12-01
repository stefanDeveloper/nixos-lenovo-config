{ pkgs, ... }:

{
  home-manager.users.stefan = {
    programs.obs-studio = {
      enable = true;
      package = pkgs.obs-studio;
    };
  };
}
