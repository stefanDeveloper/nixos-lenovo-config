{ pkgs, ... }:

{
  users = {
    users = {
      stefan = {
        isNormalUser = true;
        description = "Stefan Machmeier";
        createHome = true;
        initialPassword = "whatever";
        shell = pkgs.zsh;
        home = "/home/stefan";
        extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
      };
    };
  };
}