{ pkgs, ... }:

{
  home-manager.users.stefan = {
    home.file = {
      "autorandr" = {
        source = ./autorandr;
        target = ".config/autorandr";
      };
    };
  };
}
