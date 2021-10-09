# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;

      grub = {
        # Disable the GNU GRUB boot loader.
        enable = lib.mkForce false;
        # Automatically add other operating system to the grub menu
        useOSProber = true;
      };
    };
  };

}