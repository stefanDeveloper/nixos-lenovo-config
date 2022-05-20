{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lynx
  ];
}