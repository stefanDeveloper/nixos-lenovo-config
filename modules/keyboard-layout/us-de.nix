{ config, pkgs, ...  }:

{
  services.xserver.extraLayouts.us-de = {
    description = "IBM layout with DE umlauts";
    languages   = [ 
      "en"
      "de"
    ];
    symbolsFile = ./us-de;
  };
}
