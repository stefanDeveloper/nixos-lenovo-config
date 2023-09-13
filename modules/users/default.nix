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
        extraGroups = [ 
          "wheel"
          "video"
          "audio"
          "jackaudio"
          "networkmanager"
          "input"
          "scanner"
          "lp"

          # access to the serial and USB ports
          "dialout"

          # grant access to Android Debug Bridge (ADB)
          "adbusers"

          "vboxusers"
          "wireshark"
          "docker"
        ]; # Enable ‘sudo’ for the user.
      };
    };
  };
  nix.settings.trusted-users = [ "root" "stefan" ];
}
