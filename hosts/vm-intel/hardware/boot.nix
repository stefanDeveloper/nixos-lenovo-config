{ config, modulesPath, ... }:
{
  boot = {
    initrd = {
      availableKernelModules = [
        "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "sd_mod" "sr_mod" "nvme"
      ];
      kernelModules = [ ];
    };
    
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

}
