{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.stefan = {
      news.display = "silent";

      # Start new or changed services automatically.
      # Stop obsolte services from the previous generation
      systemd.user.startServices = true;

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      home.stateVersion = "21.05";
    };
  };
}