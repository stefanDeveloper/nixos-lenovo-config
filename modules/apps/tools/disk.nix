{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ncdu
    parted
  ];
}
