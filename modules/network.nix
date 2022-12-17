{ pkgs, ... }:
{
  services.resolved.enable = true;
  networking = {
    search = [ "iwr.uni-heidelberg.de" ];
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
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "spoof-mac" ''
      sudo ip link set dev enp6s0f4u1u2 down
      sudo ip link set dev enp6s0f4u1u2 address 54:05:DB:F5:46:EF
      sudo ip link set dev enp6s0f4u1u2 up
    '')
  ];
}
