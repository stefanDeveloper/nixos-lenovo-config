{ pkgs, ... }:

{
  users = {
    mutableUsers = true;
    # defaultUserShell = pkgs.zsh;
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
  # NixOS 22.05
  # nix.settings.trusted-users = [ "root" "stefan" ];
  # Until NixOS 21.11
  nix.trustedUsers = [ "root" "stefan" ];
  security.sudo.wheelNeedsPassword = false;
}