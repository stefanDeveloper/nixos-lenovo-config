{ config, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.stefan = {
      news.display = "silent";

      # Start new or changed services automatically.
      # Stop obsolte services from the previous generation
      systemd.user.startServices = true;

      home.stateVersion = "21.11";
    };
  };
}