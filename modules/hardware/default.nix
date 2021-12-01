{ pkgs, ... }:

{
  imports = [
    ./sound.nix
    ./bluetooth.nix
  ];
  hardware = {
    enableRedistributableFirmware = true;
    enableAllFirmware = true;
    firmware = with pkgs; [
      wireless-regdb
    ];
  };
}
