{ config, modulesPath, pkgs, ... }:
{
  boot = {
    initrd = {
      availableKernelModules = [
        "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "sd_mod" "sr_mod" "nvme"
      ];
      kernelModules = [ pkgs.linuxPackages_latest ];
    };
    
    kernelModules = [ ];
    extraModulePackages = [ ];
    supportedFilesystems = lib.mkForce [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];
  };

}
