{
  networking = {
      hostName = "nixos-work";
      interfaces = {
          enp2s0f0.useDHCP = true;
          wlp3s0.useDHCP = true;
      };
  };
}