{

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/68a45e06-e46a-4b2d-b59e-2e53641fc6cb";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1F37-2D57";
      fsType = "vfat";
    };
    
  swapDevices =
    [ { device = "/dev/disk/by-uuid/f8459535-180e-4d0c-8a93-5e736ade1fb8"; }
    ];

}