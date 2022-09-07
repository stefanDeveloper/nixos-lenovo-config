{
  networking = {
    hostName = "nixos-stefan";
    interfaces = {
      enp2s0f0.useDHCP = true;
      enp5s0.useDHCP = true;
    };
  };
}
