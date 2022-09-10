# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

let
  ibm_plymouth_theme = pkgs.callPackage ./plymouth/ibm.nix { };
in
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    loader = {
      systemd-boot.enable = pkgs.system == "x86_64-linux";
      efi.canTouchEfiVariables = true;

      grub = {
        # Disable the GNU GRUB boot loader.
        enable = lib.mkForce false;
        # Automatically add other operating system to the grub menu
        useOSProber = true;
      };

    };

    # Use the latest Linux kernel packages
    # kernelPackages = pkgs.linuxPackages_latest;

    # Enable plymouth boot splash screen
    plymouth = {
      enable = true;
      theme = "ibm";
      themePackages = [ ibm_plymouth_theme ];
    };

    # Delete all files in /tmp during boot
    cleanTmpDir = true;

    # quite - Don't show terminal output unless an error occurs
    # splash - Show splash screen theme (if available)
    # pti on/off - Enable/disable Page Table Isolation (PTI).
    #              Protects from attacks on the shared user/kernel address space,
    #              but with a cost of a little perfomance overhead
    kernelParams = [ "quiet" "splash" ];

    # All Kernel Messages with a log level smaller
    # than this setting will be printed to the console
    consoleLogLevel = 3;

    kernel = {
      # Enable all functions of sysrq. It is a magical key combo
      # you can hit which the kernel will respond to regardless of
      # whatever else it is doing, unless it is completely locked up.
      # On x86: ALT+PSc/SRq+<command key>
      sysctl."kernel/sysrq" = 1;
    };
  };
}
