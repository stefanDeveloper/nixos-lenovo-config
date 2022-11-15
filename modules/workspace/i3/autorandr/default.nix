{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arandr
    autorandr
  ];

  home-manager.users.stefan = {
    home.file = {
      "autorandr" = {
        source = ./config;
        target = ".config/autorandr";
      };
    };
  };
}
