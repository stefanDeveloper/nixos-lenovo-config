{config, ...}:
{
   boot = {
    initrd = {
      availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
      kernelModules = [ ];
    };
    
    kernelModules = [ "kvm-amd" ];

    extraModulePackages = [ config.boot.kernelPackages.rtw89 ];
  };

}