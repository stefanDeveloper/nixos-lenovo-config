{ config, lib, ... }:
{
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/e01213a3-8238-46d6-b06f-9e2393566a6b";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/0D75-464B";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/928cb865-8e32-45b5-a20b-ee482a945bb7"; }];

  # Supposedly better for the SSD.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}
