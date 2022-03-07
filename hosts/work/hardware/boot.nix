{config, modulesPath, ...}:
{
   boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "intel_pstate=no_hwp" ];
    initrd = {
      availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" "aesni_intel" "cryptd"];
      luks.devices.luksroot =
      {
        device = "/dev/disk/by-uuid/5e06be4d-e296-4378-9d32-d02b4312e61a";
        preLVM = true;
        allowDiscards = true;
      };

      kernelModules = [ "dm-snapshot" ];
    };

    kernelModules = [ "kvm-amd" ];

    extraModulePackages = [ config.boot.kernelPackages.rtw89 ];
  };

}