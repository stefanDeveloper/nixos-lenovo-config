{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.stefan = {
    programs.git = {
      enable = true;
      userName  = "Stefan Machmeier";
      userEmail = "stefan-machmeier@outlook.com";
    };
  };
}
