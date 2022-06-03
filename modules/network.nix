{
  services.resolved.enable = true;
  networking = {
      networkmanager = {
          enable = true;
          dns = "systemd-resolved";
      };
      nameservers = [ "129.206.7.220" "1.1.1.1" "9.9.9.9" ];
      # The global useDHCP flag is deprecated, therefore explicitly set to false here.
      # Per-interface useDHCP will be mandatory in the future, so this generated config
      # replicates the default behaviour.
      useDHCP = false;
  };
}