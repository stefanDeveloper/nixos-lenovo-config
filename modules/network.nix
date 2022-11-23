{
  services.resolved.enable = true;
  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      # insertNameservers = [ "xxx.xxx.xxx.xxx" ];
    };
    # nameservers = [ "xxx.xxx.xxx.xxx" ];
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
  };
}

# sudo systemd-resolve --set-dns 129.206.7.220 --interface enp2s0f0
