{ config, pkgs, ...  }:

{
  services.xserver.extraLayouts.us-de = {
    description = "IBM layout with DE umlauts";
    languages   = [ 
      "us"
      "de"
    ];
    symbolsFile = ./us-de;
  };
}
