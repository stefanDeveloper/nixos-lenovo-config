{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # If you activates this, building increase tremendously
      <nixos-hardware/lenovo/thinkpad/t14/amd/gen1>
    ];
  
  hardware = {
    enableRedistributableFirmware = true;
    enableAllFirmware = true;
    firmware = with pkgs; [
      wireless-regdb
    ];
  };
}
