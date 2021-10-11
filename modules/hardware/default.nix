{ pkgs, ... }:

{
  hardware = {
    enableRedistributableFirmware = true;
    enableAllFirmware = true;
    firmware = with pkgs; [
      wireless-regdb
    ];
  };
}