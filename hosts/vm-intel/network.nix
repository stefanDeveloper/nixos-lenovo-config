{
  networking = {
    hostName = "nixos-work";
    useDHCP = false;
    interfaces = {
      ens33.useDHCP = true;
    };
  };
}
