{ config, pkgs, ...  }:

{
  services.xserver.extraLayouts.us-de = {
    description = "US layout with DE umlauts";
    languages   = [ "eng" ];
    symbolsFile = /etc/nixos/symbols/us-de;
  };
}
