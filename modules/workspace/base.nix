{ pkgs, lib, config, inputs, ... }:

{
  home-manager.users.stefan = {

    # Use services.flameshot.enable = true instead
    # See: https://github.com/nix-community/home-manager/issues/2064
    home.packages = with pkgs; [ flameshot ];

    home.activation."mimeapps-remove" = {
      before = [ "linkGeneration" ];
      after = [ ];
      data = "rm -f /home/vyorkin/.config/mimeapps.list";
    };
  };
}